#!/bin/bash
# ==========================================
# Script Setup Node Laravel & MariaDB
# Usage: ./script.sh [palantir|elendil|isildur|anarion]
# ==========================================

NODE=$1
LARAVEL_PATH="/var/www/laravel-simple-rest-api"
PHP_SOCK="/var/run/php/php8.4-fpm.sock"

if [ -z "$NODE" ]; then
    echo "Usage: $0 [palantir|elendil|isildur|anarion]"
    exit 1
fi

# ------------------------
# Node Palantir - MariaDB
# ------------------------
if [ "$NODE" = "palantir" ]; then
    apt-get update
    apt-get install -y mariadb-server mariadb-client

    service mariadb start
    sleep 3

    mysql -e "CREATE DATABASE IF NOT EXISTS laravel_db;"
    mysql -e "CREATE USER IF NOT EXISTS 'k35'@'%' IDENTIFIED BY '123';"
    mysql -e "GRANT ALL PRIVILEGES ON laravel_db.* TO 'k35'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
    service mariadb restart

    echo "=== Palantir MariaDB setup selesai ==="
    exit 0
fi

# ------------------------
# Nodes Laravel Setup
# ------------------------
if [[ "$NODE" = "elendil" || "$NODE" = "isildur" || "$NODE" = "anarion" ]]; then
    apt-get update
    apt-get install -y php8.4-fpm php8.4-mysql mariadb-client nginx curl unzip git

    cd $LARAVEL_PATH || exit

    # Konfigurasi .env sesuai node
    case "$NODE" in
        elendil)
            DB_USER="k35"
            DB_PASS="123"
            DB_HOST="10.81.4.3"
            PORT=8001
            ;;
        isildur)
            DB_USER="k35"
            DB_PASS="123"
            DB_HOST="10.81.4.3"
            PORT=8002
            ;;
        anarion)
            DB_USER="k35"
            DB_PASS="123"
            DB_HOST="10.81.4.3"
            PORT=8003
            ;;
    esac

    cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=$DB_HOST
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=$DB_USER
DB_PASSWORD=$DB_PASS
EOF

    php artisan key:generate

    # Hanya untuk Elendil: migrate dan seed
    if [ "$NODE" = "elendil" ]; then
        php artisan migrate:fresh --seed
    fi

    # Konfigurasi Nginx
    cat > /etc/nginx/sites-available/$NODE << EOF
server {
    listen $PORT;
    server_name $NODE.k35.com;

    root $LARAVEL_PATH/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$PHP_SOCK;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    ln -sf /etc/nginx/sites-available/$NODE /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default

    # Permission Laravel
    chown -R www-data:www-data $LARAVEL_PATH
    chmod -R 775 $LARAVEL_PATH/storage $LARAVEL_PATH/bootstrap/cache

    php artisan config:clear
    php artisan cache:clear
    php artisan route:clear
    php artisan view:clear

    nginx -t
    service nginx restart
    service php8.4-fpm restart

    echo "=== $NODE Laravel + Nginx setup selesai ==="
    exit 0
fi

echo "Node tidak dikenal: $NODE"
exit 1
