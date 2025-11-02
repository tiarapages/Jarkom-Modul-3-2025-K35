# Jalankan di Galadriel, Celebron, Oropher


# Install nginx dan php8.4-fpm
apt-get update
apt-get install nginx php8.4-fpm -y



# Buat direktori web
mkdir -p /var/www/html


nano /var/www/html/index.php

# Celeborn

<?php
echo "Selamat datang di Taman Digital Celeborn\n";?>


# Galadriel


<?php
echo "Selamat datang di Taman Digital Galadriel\n";?>


# Oropher


<?php
echo "Selamat datang di Taman Digital Oropher\n";?>


nano /etc/nginx/sites-available/celeborn


server {
    listen 80 default_server;
    server_name celeborn.k35.com www.celeborn.k35.com;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}


nano /etc/nginx/sites-available/oropher

bash
server {
    listen 80 default_server;
    server_name oropher.k35.com www.oropher.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}


nano /etc/nginx/sites-available/galadriel

bash
server {
    listen 80 default_server;
    server_name galadriel.k35.com www.galadriel.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}


Ganti dgn Galadriel, Oropher, celeborn


# Aktifkan konfigurasi
ln -s /etc/nginx/sites-available/oropher /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default



# Start services
service php8.4-fpm start
service nginx start


# Test

curl http://galadriel.k35.com
curl http://celeborn.k35.com
curl http://oropher.k35.com
