#!/bin/bash
# usage: ./deploy_ratelimit.sh elros
NAME="$1"
if [ -z "$NAME" ]; then
  echo "Usage: $0 <site-name (elros|pharazon)>"
  exit 1
fi

CONF_ZONE="/etc/nginx/conf.d/ratelimit_k35.conf"
SITE_FILE="/etc/nginx/sites-available/${NAME}"

# buat limit_req_zone global (http context)
cat > "$CONF_ZONE" <<'EOF'
limit_req_zone $binary_remote_addr zone=one:10m rate=10r/s;
EOF

# jika file site ada, backup dan sisipkan limit_req pada lokasi pertama "location / {"
if [ -f "$SITE_FILE" ]; then
  cp -a "$SITE_FILE" "${SITE_FILE}.bak.$(date +%s)"
  awk '
  BEGIN{inserted=0}
  {
    print $0
    if(!inserted && $0 ~ /location[[:space:]]+\/[[:space:]]*\{/){
      print "            limit_req zone=one burst=20 nodelay;"
      inserted=1
    }
  }
  ' "${SITE_FILE}.bak.$(date +%s)" > "${SITE_FILE}.new" 2>/dev/null || true

  # fallback: if awk failed to create new (e.g. permission), try sed insert after location / {
  if [ ! -f "${SITE_FILE}.new" ]; then
    sed -e '/location[[:space:]]\+\/[[:space:]]*{/a\            limit_req zone=one burst=20 nodelay;' "${SITE_FILE}.bak.$(date +%s)" > "${SITE_FILE}.new" 2>/dev/null || true
  fi

  if [ -f "${SITE_FILE}.new" ]; then
    mv -f "${SITE_FILE}.new" "$SITE_FILE"
  fi
else
  # jika tidak ada site file, buat satu sederhana yang hanya menerapkan limit (tidak mengubah upstream)
  cat > "$SITE_FILE" <<EOF
server {
    listen 80;
    server_name ${NAME}.k35.com;

    location / {
        limit_req zone=one burst=20 nodelay;
        return 503;
    }
}
EOF
fi

# test dan restart nginx (tanpa systemctl)
nginx -t && service nginx restart || (nginx -t && nginx -s reload)
