# tambahkan header X-Real-IP

fastcgi_param HTTP_X_REAL_IP $remote_addr;

# Update konfigurasi nginx di ketiga nodes

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
        fastcgi_param HTTP_X_REAL_IP $remote_addr;
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
        fastcgi_param HTTP_X_REAL_IP $remote_addr;
    }
}

# update file index.php

<?php
echo "Selamat datang di Taman Digital Galadriel\n";
echo "Hostname: " . gethostname() . "\n";
echo "Server IP Address: " . $_SERVER['SERVER_ADDR'] . "\n";
echo "Visitor IP Address: " . (isset($_SERVER['HTTP_X_REAL_IP']) ? $_SERVER['HTTP_X_REAL_IP'] : $_SERVER['REMOTE_ADDR']) . "\n";
?>

# restart

service nginx restart

# test semua
curl -u noldor:silvan http://galadriel.k35.com
curl -u noldor:silvan http://10.81.2.2:8004
curl -u noldor:silvan http://10.81.2.3:8005
curl -u noldor:silvan http://10.81.2.4:8006

### Hasilnya akan tampil seperti:


### Selamat datang di Taman Digital Galadriel
### Hostname: Galadriel
### Server IP Address: 10.81.2.2
### Visitor IP Address: 10.81.x.x
