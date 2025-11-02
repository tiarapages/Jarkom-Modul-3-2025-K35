# Di Galadriel - Port 80 DAN 8004:

nano /etc/nginx/sites-available/galadriel

server {
    listen 80;
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

server {
    listen 8004;
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


# Di Celeborn - Port 80 DAN 8005

nano /etc/nginx/sites-available/celeborn

server {
    listen 80;
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

server {
    listen 8005;
    server_name celeborn.k35.com www.celeborn.k35.com;
    
    root /var/www/html;
    index index.php ind
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
    }
}



# Di Oropher - Port 80 DAN 8006

nano /etc/nginx/sites-available/oropher

    server {
    listen 80;
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

server {
    listen 8006;
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



# klo error cb stop, start dan check

netstat -tlnp | grep nginx
