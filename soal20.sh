#!/bin/bash
# nginx_cache_pharazon.sh
# Enable Nginx caching di Pharazon dan test cache via curl

PHARAZON_IP="10.81.2.7"
DOMAIN="pharazon.k35.com"
SITE_FILE="/etc/nginx/sites-available/pharazon"
CACHE_PATH="/var/cache/nginx/pharazon_cache"

# 1) Buat direktori cache jika belum ada
mkdir -p "$CACHE_PATH"
chown -R www-data:www-data "$CACHE_PATH"

# 2) Buat file konfigurasi cache global jika belum ada
CACHE_CONF="/etc/nginx/conf.d/cache_k35.conf"
cat > "$CACHE_CONF" <<EOF
proxy_cache_path $CACHE_PATH levels=1:2 keys_zone=pharazon_cache:10m inactive=60m use_temp_path=off;
EOF

# 3) Sisipkan proxy_cache pada location / di site Pharazon
if [ -f "$SITE_FILE" ]; then
  cp -a "$SITE_FILE" "${SITE_FILE}.bak.$(date +%s)"
  awk '
  BEGIN{inserted=0}
  {
    print $0
    if(!inserted && $0 ~ /location[[:space:]]+\/[[:space:]]*\{/){
      print "            proxy_cache pharazon_cache;"
      print "            proxy_cache_valid 200 60m;"
      print "            add_header X-Cache-Status \$upstream_cache_status;"
      inserted=1
    }
  }
  ' "${SITE_FILE}.bak.$(date +%s)" > "${SITE_FILE}.new" || true
  if [ -f "${SITE_FILE}.new" ]; then
    mv -f "${SITE_FILE}.new" "$SITE_FILE"
  fi
else
  cat > "$SITE_FILE" <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_cache pharazon_cache;
        proxy_cache_valid 200 60m;
        add_header X-Cache-Status \$upstream_cache_status;
        proxy_pass http://127.0.0.1:8002;
    }
}
EOF
fi

# 4) Test konfigurasi Nginx dan reload
nginx -t && service nginx restart || (nginx -t && nginx -s reload)

# 5) Test cache via curl dari local (client bisa juga ssh dan curl)
curl -i "http://$DOMAIN" | head -15
curl -i "http://$DOMAIN" | head -15
curl -i "http://$DOMAIN" | head -15

# Akan terlihat header "X-Cache-Status: HIT" pada request kedua dan seterusnya
# Dari client jalankan test case
curl -i http://pharazon.k35.com | grep X-Cache-Status
curl -i http://pharazon.k35.com | grep X-Cache-Status
# Yang pertama MISS, yang kedua HIT