# Miriel

apt-get update
apt-get install apache2-utils -y

# Benchmark Pertama (Semua Worker Normal)

ab -n 100 -c 10 -A noldor:silvan [http://pharazon.k35.com/](http://pharazon.k35.com/)

# Parazon

tail -100 /var/log/nginx/access.log | grep "GET / HTTP" | awk '{print $1}' | sort | uniq -c

# atau

grep "GET / HTTP" /var/log/nginx/access.log | tail -100

#Simulasi Gladriel stop

service nginx stop
service nginx status

# Benchmark Kedua (Galadriel Down)

ab -n 100 -c 10 -A noldor:silvan http://pharazon.k35.com/

#M asih berhasil? → Pharazon otomatis skip Galadriel
# Ada error? → Cek konfigurasi fail_timeout

# Cek Log Pharazon (Lihat Error & Failover)

tail -50 /var/log/nginx/error.log

# Cek access log:

tail -100 /var/log/nginx/access.log | grep "GET / HTTP"

# Check manual

for i in {1..10}; do curl -H "Connection: close" -u noldor:silvan http://pharazon.k35.com 2>/dev/null | grep "Hostname"; done

# Hidupkan Galadriel

service nginx start

# Miriel

for i in {1..10}; do curl -H "Connection: close" -u noldor:silvan http://pharazon.k35.com 2>/dev/null | grep "Hostname"; done

# Coba test

ab -n 50 -c 5 -A noldor:silvan [http://pharazon.k35.com/](http://pharazon.k35.com/)

# Lalu cek log dengan upstream info:

tail -60 /var/log/nginx/access.log