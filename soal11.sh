#!/bin/bash
# ================================================
# Stress Test Elros Reverse Proxy (Node Client)
# ================================================

DOMAIN="elros.k35.com"
API_ENDPOINT="/api/airings/"
NGINX_LOG="/var/log/nginx/access.log"

# --------------------------------
# 1. Serangan Awal
# 100 request, 10 concurrent
# --------------------------------
ab -n 100 -c 10 http://$DOMAIN$API_ENDPOINT/

# --------------------------------
# 2. Pantau log Nginx Elros
# --------------------------------
tail -n 20 $NGINX_LOG

# --------------------------------
# 3. Serangan Penuh
# 2000 request, 100 concurrent
# --------------------------------
ab -n 2000 -c 100 http://$DOMAIN$API_ENDPOINT/

# --------------------------------
# 4. Pantau log Nginx Elros setelah serangan
# --------------------------------
tail -n 50 $NGINX_LOG
# 1. Cek akses Elros
curl -i http://$DOMAIN
curl -s http://$DOMAIN$API_ENDPOINT | head -5

# 2. Cek akses backend langsung
curl -i http://${BACKENDS[0]}
curl -i http://${BACKENDS[1]}
curl -i http://${BACKENDS[2]}

# 3. Tes Round Robin cepat (12 request)
ab -n 12 -c 3 http://$DOMAIN$API_ENDPOINT/