#!/bin/bash
# ==========================================
# Setup Nginx Reverse Proxy - Node Elros
# Domain: elros.k35.com
# Upstream: kesatria_numenor (Elendil, Isildur, Anarion)
# IP Elros: 10.81.1.7
# Backend IPs:
#   Elendil  10.81.1.2
#   Isildur  10.81.1.3
#   Anarion  10.81.1.4
# ==========================================

set -e

ELROS_IP="10.81.1.7"
DOMAIN="elros.k35.com"
NGINX_CONF="/etc/nginx/sites-available/elros"

# Install nginx jika belum ada
apt-get update
apt-get install -y nginx

# Buat konfigurasi Nginx
cat > $NGINX_CONF << EOF
upstream kesatria_numenor {
    server 10.81.1.2:8001;  # Elendil
    server 10.81.1.3:8002;  # Isildur
    server 10.81.1.4:8003;  # Anarion
}

server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://kesatria_numenor;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable site
ln -sf $NGINX_CONF /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test dan restart nginx
nginx -t
service nginx restart

echo "=== Nginx Reverse Proxy Elros setup selesai ==="
echo "Domain: $DOMAIN"
echo "Upstream: kesatria_numenor (Elendil, Isildur, Anarion)"
# Test akses domain Elros
curl -i http://elros.k35.com
curl -s http://elros.k35.com/api/airings | head -10

# Test akses backend langsung
curl -i http://10.81.1.2:8001
curl -i http://10.81.1.3:8002
curl -i http://10.81.1.4:8003

# Test log Nginx (tail akses log)
tail -f /var/log/nginx/access.log

# Test Round Robin dengan Apache Bench
ab -n 12 -c 3 http://elros.k35.com/

# Test menggunakan lynx (terminal browser)
lynx -dump http://elros.k35.com
