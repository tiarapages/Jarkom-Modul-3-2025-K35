# Pharazon

apt-get update
apt-get install nginx -y

nano /etc/nginx/sites-available/pharazon

upstream Kesatria_Lorien {
    server 10.81.2.2:8004 max_fails=3 fail_timeout=30s;
    server 10.81.2.3:8005 max_fails=3 fail_timeout=30s;
    server 10.81.2.4:8006 max_fails=3 fail_timeout=30s;
}

server {
    listen 80;
    server_name pharazon.k35.com www.pharazon.k35.com;
    
    location / {
        proxy_pass http://Kesatria_Lorien;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Authorization $http_authorization;
        proxy_pass_header Authorization;
        
        # Disable buffering untuk round-robin lebih jelas
        proxy_buffering off;
    }
}

service nginx restart

# uji

for i in {1..6}; do curl -H "Connection: close" -u noldor:silvan http://pharazon.k35.com; echo "---"; done
