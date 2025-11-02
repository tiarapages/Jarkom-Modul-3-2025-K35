# DI OROPHER, GALADRIEL, CELEBORN

# Install htpasswd tool:

apt-get install apache2-utils -y

# Buat file password:

htpasswd -cb /etc/nginx/.htpasswd noldor silvan

# Cek file password sudah dibuat:

cat /etc/nginx/.htpasswd

# Galadriel

server {
    listen 80;
    server_name galadriel.k35.com www.galadriel.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Galadriel Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

server {
    listen 8004;
    server_name galadriel.k35.com www.galadriel.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Galadriel Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

# Celeborn

server {
    listen 80;
    server_name celeborn.k35.com www.celeborn.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Celeborn Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

server {
    listen 8005;
    server_name celeborn.k35.com www.celeborn.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Celeborn Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

# Oropher

server {
    listen 80;
    server_name oropher.k35.com www.oropher.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Oropher Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

server {
    listen 8006;
    server_name oropher.k35.com www.oropher.k35.com;
    
    root /var/www/html;
    index index.php index.html;
    
    auth_basic "Restricted Access - Oropher Garden";
    auth_basic_user_file /etc/nginx/.htpasswd;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}

# restart

service nginx restart

# Test bener

curl -u noldor:silvan http://galadriel.k35.com
curl -u noldor:silvan http://10.81.2.2:8004
curl -u noldor:silvan http://10.81.2.3:8005
curl -u noldor:silvan http://10.81.2.4:8006

# test Salah

curl http://galadriel.k35.com
curl http://10.81.2.2:8004
