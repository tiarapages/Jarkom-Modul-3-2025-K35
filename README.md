# Jarkom-Modul-3-2025-K35

| Nama | NRP |
|---|---|
| Tiara Putri Prasetya | 5027241013 |
| Naufal Ardhana | 5027241118 |

بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ
Berikut merupakan masing masing Address pada node
| **No** | **Host (Tokoh)**  | **Address** |
| :----: | ---------------- | ------------- |
| 1 | **Aldarion**   | 10.81.4.4|
| 2 | **Amandil**| DHCP |
| 3 | **Amdir**  | 10.81.3.2 |
| 4 | **Anarion**  | 10.81.1.4 |
| 5 | **Celeborn**  | 10.81.2.3 |
| 6 | **Celebrimbor**  | 10.81.2.6 |
| 7 | **Durin**  | 10.81.1.1 |
| 8 | **Elendil** | 10.81.1.2 |
| 9 | **Erendis** | 10.81.3.3 |
| 10 | **Erlos** | 10.81.1.7 |
| 11 | **Galadriel**  | 10.81.2.2 |
| 12 | **Gilgalad**   | DHCP |
| 13 | **Isildur**| 10.81.1.3 |
| 14 | **Khamul**  | DHCP |
| 15 | **Minastir**  | 10.81.5.2 |
| 16 | **Miriel**  | 10.81.1.5 |
| 17 | **Narvi**  | 10.81.4.2 |
| 18 | **Oropher**  | 10.81.2.4 |
| 19 | **Palantir** | 10.81.4.3 |
| 20 | **Pharazon** | 10.81.2.7 |

# 1

Setiap node diatur untuk menggunakan nameserver 192.168.122.1 sebagai titik akses utama menuju jaringan luar. Hal ini dilakukan untuk memungkinkan node-node tersebut menerima instruksi awal dari Valar sebelum konfigurasi internal antar kerajaan dibentuk sepenuhnya.

Node Durin dikecualikan dari tahap ini karena memiliki fungsi khusus sebagai penghubung antar dunia, bukan sebagai bagian dari komunikasi langsung dengan Valinor.

Secara teknis, tahapan ini memastikan setiap node memiliki konfigurasi jaringan yang valid, dengan resolusi DNS mengarah ke 192.168.122.1, serta konektivitas internet aktif untuk proses sinkronisasi awal.

<img width="1061" height="816" alt="image" src="https://github.com/user-attachments/assets/bdfe3ab2-d656-4838-9aa8-6c8c4060098e" />

# 2

Aldarion bertugas sebagai server DHCP pusat yang membagikan alamat IP secara dinamis ke seluruh klien dari dua keluarga besar (Manusia dan Peri) serta memberikan alamat IP statis kepada Khamul.
Sementara itu, Durin berperan sebagai DHCP Relay Agent — ia meneruskan semua permintaan DHCP dari klien di jaringan lain agar dapat diterima dan direspons oleh server DHCP di Aldarion.

### Alur Komunikasi DHCP

- Klien di jaringan lokal (Manusia, Peri, atau Khamul) mengirim paket DHCPDISCOVER (broadcast) untuk meminta IP.

- Jika klien berada di jaringan yang tidak langsung terhubung ke Aldarion, paket tersebut diterima oleh Durin dan diteruskan (forwarded) ke Aldarion melalui IP 10.81.4.4.

- Aldarion merespons dengan DHCPOFFER, yang dikirim kembali melalui Durin ke klien.

- Setelah klien menerima IP, komunikasi berlanjut normal, dan setiap klien berada di subnet yang sesuai dengan ketetapan Aldarion.

- Pengujian `ip a` pada Khamul  
<img width="1327" height="230" alt="Screenshot 2025-10-29 025737" src="https://github.com/user-attachments/assets/9699966f-7ecb-4411-b019-7b4681ea72f8" />

terlihat bahkan ip menjadi `10.81.3.95`

- Pengujian `ip a` pada Gilgalad  
<img width="1215" height="213" alt="Screenshot 2025-10-29 025751" src="https://github.com/user-attachments/assets/f14c3915-2c41-43b2-8094-261685fcf03b" />

terlihat bahkan ip menjadi `10.81.2.35`

- Pengujian `ip a` pada Amandil  
<img width="1542" height="285" alt="Screenshot 2025-10-29 025847" src="https://github.com/user-attachments/assets/03acf3e4-7f51-4c6d-81f4-1a29484f7acf" />

terlihat bahkan ip menjadi `10.81.1.6`

# 3

Minastir berfungsi sebagai DNS relay (menara pengawas) yang mengontrol dan meneruskan permintaan DNS dari node-node internal (seperti Khamul, Gilgalad, dan Amandil) ke dunia luar (Internet / Valinor). Semua lalu lintas DNS dari Arda harus melewati Minastir sebelum keluar.

### Uji Berhasil

Saat perintah ip a di Khamul, Gilgalad, dan Amandil tetap menampilkan IP lokal masing-masing, tetapi ping google.com berhasil, itu artinya mereka berhasil keluar melalui Minastir sebagai pengawas DNS.

<img width="1192" height="170" alt="image" src="https://github.com/user-attachments/assets/a1b90847-b729-43db-8a5c-270376884e6a" />

# 4

Erendis, sebagai pembuat peta digital dunia Arda, bertugas menetapkan zona DNS utama untuk domain k35.com. Ia menunjuk dirinya sebagai nameserver utama (ns1.k35.com) dan muridnya Amdir sebagai nameserver sekunder (ns2.k35.com).
Sistem ini memastikan bahwa seluruh lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, dan Oropher) dapat diakses melalui nama domain yang unik.
Selain itu, konfigurasi master–slave DNS replication menjamin Amdir selalu menyalin data zona terbaru dari Erendis secara otomatis.

### Uji koneksi DNS

```
ping k35.com
ping ns1.k35.com
ping ns2.k35.com
ping anarion.k35.com
ping galadriel.k35.com
```

<img width="691" height="726" alt="image" src="https://github.com/user-attachments/assets/53b9f538-162d-46c6-9036-ba85142dfc07" />

# 5

### Erendis memperluas sistem pemetaan digital k35.com dengan menambahkan:

- Alias domain (CNAME) www.k35.com agar pengguna mudah mengakses peta utama.

- Reverse DNS (PTR record) untuk melacak lokasi fisik (IP address) Erendis dan Amdir.

- Pesan rahasia (TXT record) yang berisi “Cincin Sauron” dan “Aliansi Terakhir” untuk melambangkan hubungan tersembunyi antara Elros dan Pharazon.

- Semua perubahan ini harus direplikasi ke Amdir (slave) agar kedua server DNS menyimpan data zona yang sama dan tetap sinkron.

Pertama lakukan edit `nano /etc/bind/zones/k35.com` masukkan `echo nameserver 10.81.5.2 > /etc/resolv.conf
`
```
$TTL    604800          ; Waktu cache default (detik)

@       IN      SOA     k35.com. root.k35.com. (

                        2025100402 ; Serial (format YYYYMMDDXX)

                        604800     ; Refresh (1 minggu)

                        86400      ; Retry (1 hari)

                        2419200    ; Expire (4 minggu)

                        604800 )   ; Negative Cache TTL

;



@       IN      NS      ns1.k35.com.

@       IN      NS      ns2.k35.com.

@       IN      A       10.81.3.3;

ns1     IN      A       10.81.3.3;

ns2     IN      A       10.81.3.2;

palantir  IN    A       10.81.4.3;

elros     IN      A       10.81.1.7;

pharazon  IN      A       10.81.2.7;

elendil   IN      A       10.81.1.2;

isildur   IN      A       10.81.1.3;

anarion   IN      A       10.81.1.4;

galadriel IN      A       10.81.2.2;

celeborn  IN      A       10.81.2.3;

oropher   IN      A       10.81.2.4;

www     IN      CNAME   k35.com.



erendis IN      A       10.81.3.3;

erendis IN      TXT     "Cincin Sauron=elros.k35.com"

erendis IN      TXT     "Aliansi Terakhir=pharazon.k35.com"
```
edit `nano /etc/bind/zones/db.10.81.3`
```
$TTL    604800
@       IN      SOA     k35.com. root.k35.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.k35.com.

; PTR Records untuk Erendis dan Amdir
2       IN      PTR     amdir.k35.com.
3       IN      PTR     erendis.k35.com.
```
edit `nano /etc/bind/named.conf.local`
```
zone "3.81.10.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.10.81.3";
};
```
cek semua file konfigurasi di erendis
```
named-checkconf
named-checkzone k35.com /etc/bind/zones/k35.com
named-checkzone 3.81.10.in-addr.arpa /etc/bind/zones/db.10.81.3
```
jalankan restart bind9 `service bind9 restart`
uji di client
`dig www.k35.com`
Lacak erendis dari ip
`dig -x 10.81.3.3`
Baca pesan txt
`dig TXT erendis.k35.com`

<img width="840" height="517" alt="Screenshot 2025-11-02 154505" src="https://github.com/user-attachments/assets/0235299f-1433-478b-8870-15815dc3311e" />
<img width="1028" height="498" alt="Screenshot 2025-11-02 154514" src="https://github.com/user-attachments/assets/5c34e0db-db16-4e4c-9bbb-452819a6c5e2" />
<img width="834" height="543" alt="Screenshot 2025-11-02 154522" src="https://github.com/user-attachments/assets/f201617c-4eac-425d-b34a-a24ecacf67a0" />


# 6

Aldarion menetapkan sistem pengaturan waktu peminjaman tanah yang berbasis pada jenis client dinamis di jaringan. Pengaturan ini diterapkan melalui mekanisme Dynamic Host Configuration Protocol (DHCP) untuk mengatur lease time atau masa berlaku alamat IP yang diberikan kepada setiap client.

Dalam konfigurasi tersebut, terdapat dua jenis client utama dengan durasi lease yang berbeda:

- Client Dinamis Keluarga Manusia memperoleh waktu peminjaman selama setengah jam (1800 detik).

- Client Dinamis Keluarga Peri memperoleh waktu peminjaman selama seperenam jam (600 detik).

Selain itu, Aldarion menetapkan batas maksimum lease time selama satu jam (3600 detik) untuk seluruh client tanpa kecuali.
Dengan demikian, setiap node client akan memperoleh alamat IP sementara yang sesuai dengan ketentuan jenisnya, dan sistem DHCP akan secara otomatis memperbarui atau mencabut peminjaman setelah durasi tersebut berakhir.

- Konfigurasi di aldarion `nano /etc/dhcp/dhcpd.conf`
  
- Lakukan beberapa perubahan 
```
default-lease-time 600;  # Biarkan ini atau hapus
max-lease-time 3600;     # <-- UBAH INI (dari 7200)
```

- Tambahkan default time di masing masing node manusia dan peri
```
default-lease-time 1800;   # 30 menit
max-lease-time 3600;       # 1 jam
```

- restart dhcp `/etc/init.d/isc-dhcp-server restart`

# 7

Para Ksatria Númenor (Elendil, Isildur, dan Anarion ) memulai pembangunan benteng pertahanan digital mereka menggunakan teknologi Laravel sebagai fondasi utama.
Masing-masing node kerajaan dikonfigurasi sebagai worker Laravel, yang bertanggung jawab untuk menjalankan framework dan menerima resource utama dari Resource-Laravel sebagai cetak biru atau template awal sistem.

Untuk mendukung operasional Laravel, setiap node dipersiapkan dengan instalasi PHP 8.4, Composer, dan Nginx sebagai web server utama. Integrasi antara ketiga komponen tersebut memastikan Laravel dapat berjalan secara optimal dan siap menerima permintaan dari jaringan kerajaan lainnya.

Setelah proses instalasi dan pengambilan resource blueprint dari Resource-Laravel selesai, pengujian konektivitas serta validasi tampilan dilakukan melalui client menggunakan peramban berbasis teks Lynx, guna memastikan bahwa setiap node Laravel berhasil menampilkan halaman default Laravel dan berfungsi dengan benar dalam lingkungan jaringan yang telah dibangun.

- jalankan update dan install
```
apt update
apt install -y php8.4 php8.4-cli php8.4-fpm php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip php8.4-sqlite3 php8.4-mysql nginx git unzip curl
apt install -y nginx
```

- install composer 
```
curl -sS https://getcomposer.org/installer | php
cd .. /root
mv composer.phar /usr/local/bin/composer
cd /var/www
```

- Jika masih error jalankan
```
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer --version
```

- clone github api dari laravel
```
cd /var/www
git clone https://github.com/elshiraphine/laravel-simple-rest-api laravel
cd laravel
```

- Install laravel dependencies
```
composer clear-cache
composer config platform.php 8.2.0
composer update --no-scripts
composer install
```

- copy file environment
```
cp .env.example .env
php artisan key:generate
```

- Atur permission di chown
```
chown -R www-data:www-data /var/www/laravel
chmod -R 755 /var/www/laravel
```

- Configurasi nginx laravel
```
server {
    listen 80;
    server_name _;

    root /var/www/laravel/public;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

- Aktifkan situs nginx dan hapus default
```
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
service nginx restart
service php8.4-fpm restart
```

- Uji di node lain
```
apt install lynx -y
lynx http://10.81.1.2
lynx http://10.81.1.3
lynx http://10.81.1.4
```
<img width="818" height="410" alt="image" src="https://github.com/user-attachments/assets/fb7b3a11-c5a6-4347-955f-29de2a59e689" />

# 8

Setiap benteng Númenor (Elendil, Isildur, Anarion) harus: (1) terhubung ke sumber pengetahuan Palantir melalui konfigurasi database di file .env pada masing-masing worker Laravel; (2) mengekspose gateway HTTP unik (Elendil: 8001, Isildur: 8002, Anarion: 8003); (3) menjalankan migrasi + seeding awal hanya dari Elendil; dan (4) menolak akses langsung via alamat IP, hanya menerima request yang memakai server_name (domain).

- Dalam Palantir download maria-db
```
apt update -y
apt install -y mariadb-server
service mariadb start
```

- buat user
```
mysql -e "CREATE DATABASE IF NOT EXISTS laravel_db;"
mysql -e "CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password123';"
mysql -e "GRANT ALL PRIVILEGES ON laravel_db.* TO 'user'@'%';"
mysql -e "FLUSH PRIVILEGES;"
```

edit konfigurasi `sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf` dan lanjutkan restart mariadb `service mariadb restart`

- Di Node elendil jalankan konfigurasi
```
cd /var/www/laravel-simple-rest-api

cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=10.81.4.3
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=user
DB_PASSWORD=password123
EOF

```
- generate `php artisan key:generate` dan jalankan git clone
  
- Jalankan `php artisan migrate:fresh --seed`
```
cat > /etc/nginx/sites-available/elendil << EOF
# Default server - reject requests via IP
server {
    listen 8001 default_server;
    server_name _;
    return 444;
}

# Main server - only accept requests via domain
server {
    listen 8001;
    server_name elendil.k35.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
```

- DI NODE ISILDUR jalankan  konfigurasi yang sama
````
mv /var/www/laravel /var/www/laravel-simple-rest-api
cd /var/www/laravel-simple-rest-api
````

- Isi file.env
```
cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=10.81.4.3
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=user
DB_PASSWORD=password123
EOF
```

- Generate artisan php `php artisan key:generate` Dan masukkan konfigurasi
```
cat > /etc/nginx/sites-available/isildur << EOF
server {
    listen 8002 default_server;
    server_name _;
    return 444;
}

server {
    listen 8002;
    server_name isildur.k35.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
```

- Hapus default config
```
ln -s /etc/nginx/sites-available/isildur /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
```

- Dan beri hak akses terhadap konfigurasi kita
```
cd /var/www/laravel-simple-rest-api
chown -R www-data:www-data .
chmod -R 775 storage bootstrap/cache
```

- Hapus sisa chace agar program bersih dan start php serta nginx
```
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

nginx -t
service nginx restart
service php8.4-fpm restart
```

- DI NODE ANARION
````
mv /var/www/laravel /var/www/laravel-simple-rest-api
cd /var/www/laravel-simple-rest-api
````

- Isi file .env
```
cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=10.81.4.3
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=user
DB_PASSWORD=password123
EOF
```

- Jalankan artisan generate `php artisan key:generate`
Isi file sites available dengan konfigurasi yang benar
```
cat > /etc/nginx/sites-available/anarion << EOF
# Default server - reject requests via IP
server {
    listen 8003 default_server;
    server_name _;
    return 444;
}

# Main server - only accept requests via domain
server {
    listen 8003;
    server_name anarion.k35.com;

    root /var/www/laravel-simple-rest-api/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
```

- Hapus konfigurasi default
```
ln -s /etc/nginx/sites-available/anarion /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
```

- Ubah hak akses terhadap cache
```
cd /var/www/laravel-simple-rest-api
chown -R www-data:www-data .
chmod -R 775 storage bootstrap/cache
```

- Hapus cache dan start nginx serta php
```
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

nginx -t
service nginx restart
service php8.4-fpm restart
```
# 9

Pada No 9 kita hanya diminta untuk menguji no 8 yang sudah tersolve dengan benar sehingga dapat terhsrae dengan baik antar node laravel. Memastikan tiap benteng (Elendil, Isildur, Anarion) berfungsi secara mandiri: dari client masing-masing, buka halaman utama Laravel dengan lynx dan panggil endpoint data


```
# Node Miriel, Celebrimbor, Gilgalad, Amandil
echo "nameserver 10.81.3.3" > /etc/resolv.conf

# Test setiap worker
lynx http://elendil.k35.com:8001
lynx http://isildur.k35.com:8002
lynx http://anarion.k35.com:8003

# Test API endpoint
curl http://elendil.k35.com:8001/api/airing
curl http://isildur.k35.com:8002/api/airing
curl http://anarion.k35.com:8003/api/airing
```
<img width="1373" height="223" alt="image" src="https://github.com/user-attachments/assets/7dcbc3ea-a38e-4586-a44a-f0116a50026d" />

# 10

Elros menggunakan Nginx untuk membentuk sebuah blok upstream bernama kesatria_numenor, yang berisi alamat tiga worker Laravel milik Elendil, Isildur, dan Anarion. Setiap permintaan yang datang ke domain elros.<xxxx>.com akan diteruskan secara merata (load balancing) ke ketiga backend tersebut menggunakan algoritma Round Robin bawaan Nginx.

Konfigurasi ini memungkinkan distribusi beban permintaan dilakukan secara seimbang antar benteng, sehingga jika salah satu node menerima trafik tinggi, permintaan berikutnya akan dialihkan ke node lainnya. Dengan demikian, Elros berperan sebagai pusat koordinasi yang memastikan seluruh benteng Númenor tetap responsif, efisien, dan mampu menghadapi lonjakan permintaan tanpa bergantung pada satu titik saja.

Selain itu, pembatasan akses berbasis domain juga diterapkan agar seluruh trafik hanya dapat masuk melalui nama domain resmi elros.<xxxx>.com, sehingga koneksi langsung melalui alamat IP tidak diizinkan. Mekanisme ini menjaga keamanan dan konsistensi jalur komunikasi antara pengguna luar dan jaringan pertahanan digital Númenor.
Di no 10 kita akan diminta untuk edit konfigurasi nginx dan server block di dalam elros

Pertama install nginx `pt-get update && apt-get install -y nginx`
Disini kita akan membuat upstream group yang berisi 3 backend bernama `kestaria numenor`
```
cat > /etc/nginx/sites-available/elros << EOF
upstream kesatria_numenor {
    server 10.81.1.2:8001;
    server 10.81.1.3:8002;
    server 10.81.1.4:8003;
}

server {
    listen 80 default_server;
    server_name _;
    return 444;
}

# Main server - only accept requests via domain
server {
    listen 80;
    server_name elros.k35.com;

    location / {
        proxy_pass http://kesatria_numenor;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    access_log /var/log/nginx/elros_access.log;
    error_log /var/log/nginx/elros_error.log;
}
EOF
```
Disitu kita juga akan menerima semua request dan menolak http 444 yang berarti koneksi ditutup tanpa respons HTTP (spesifik Nginx).
Kita juga akan mengkonfigurasi untuk Menerima request hanya untuk domain elros.k35.com dan meneruskan upstream kestaria_numenor, header juga ditambahkan didalam ip client. Log akses dan eror juga akan disimpan secara terpisah.
Kemudian kita akan membuat symlink untuk aktivasi dan hapus konfigurasi default
```
ln -s /etc/nginx/sites-available/elros /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
```
Lalu jalankan service nginx
```
nginx -t
service nginx restart
```
Sebelum melakukan testing kita harus mengecek bahwa nginx benar benar dapat berfungsi dengan baik melalui perintah sederhana
```
cat /etc/nginx/sites-available/elros | grep -A 5 upstream
service nginx status
netstat -tulpn | grep :80
```
Selanjutnya kita harus mengecek langsung dari ip elros


# 12

Para Penguasa Peri (Galadriel, Celeborn, Oropher) membangun layanan web menggunakan Nginx dan PHP-FPM sebagai fondasi taman digital mereka. Setiap node berfungsi sebagai server mandiri yang menampilkan identitas host-nya melalui halaman index.php sederhana. Konfigurasi Nginx harus memastikan eksekusi PHP berjalan melalui php8.4-fpm, serta membatasi akses hanya melalui domain resmi masing-masing (misalnya galadriel.<xxxx>.com), sehingga akses langsung via IP ditolak. Tujuan akhirnya adalah menciptakan sistem web berbasis domain yang terisolasi namun konsisten di seluruh node.

### Tools
- **Nginx** → Bertugas sebagai web server utama yang menerima request HTTP dan meneruskannya ke PHP-FPM untuk dieksekusi.  
- **PHP 8.4-FPM (FastCGI Process Manager)** → Menangani pemrosesan file PHP yang diminta oleh Nginx.  
- **File `index.php`** → Berisi konten sederhana yang menampilkan pesan identitas tiap node, menandakan bahwa server berfungsi dengan benar.  
- **Konfigurasi Virtual Host (server block)** → Menentukan domain yang valid untuk setiap node agar akses berbasis IP dapat ditolak.  


### Cara uji akses
```
curl http://galadriel.k35.com
curl http://celeborn.k35.com
curl http://oropher.k35.com

```
<img width="520" height="96" alt="Screenshot 2025-11-02 155042" src="https://github.com/user-attachments/assets/087c6214-6e23-481e-8cc9-afb0d6c70d87" />
<img width="495" height="49" alt="Screenshot 2025-11-02 155118" src="https://github.com/user-attachments/assets/e5a9335b-aa8a-4746-971d-29717488f4e2" />

# 13

Setiap node mewakili “Taman Digital” berbeda yang menampilkan halaman PHP sederhana. Sistem ini dapat digunakan untuk latihan dasar konfigurasi virtual host Nginx, pengelolaan domain lokal, serta pengujian konektivitas antar-node dalam lingkungan jaringan private

### Tools
- Nginx → Bertugas sebagai web server utama yang menerima request HTTP dan meneruskannya ke PHP-FPM untuk dieksekusi.  
- PHP 8.4-FPM (FastCGI Process Manager) → Menangani pemrosesan file PHP yang diminta oleh Nginx.  
- File `index.php` → Berisi konten sederhana yang menampilkan pesan identitas tiap node, menandakan bahwa server berfungsi dengan benar.  
- Konfigurasi Virtual Host (server block) → Menentukan domain yang valid untuk setiap node agar akses berbasis IP dapat ditolak.

### Cara uji akses
```
curl http://10.81.2.2:8004
curl http://10.81.2.3:8005
curl http://10.81.2.4:8006
```

<img width="498" height="73" alt="Screenshot 2025-11-02 155242" src="https://github.com/user-attachments/assets/891ddea2-0499-44e0-8aec-738463cf08d7" />
<img width="505" height="65" alt="Screenshot 2025-11-02 155251" src="https://github.com/user-attachments/assets/6c11b28f-f63c-413c-8afd-9a8aa8b92fb6" />

# 14

Untuk meningkatkan **keamanan akses** pada tiap taman digital, diterapkan **Basic HTTP Authentication** di level **Nginx**.  
Setiap pengunjung wajib memasukkan kredensial sebelum mengakses web:  
- Username: `noldor`  
- Password: `silvan`  

File autentikasi disimpan dalam format terenkripsi (`.htpasswd`) dan dibaca langsung oleh Nginx untuk memvalidasi setiap permintaan.  
Setiap node tetap memiliki dua port aktif — `80` dan port khusus (Galadriel `8004`, Celeborn `8005`, Oropher `8006`) dengan perlindungan autentikasi yang sama.

### Tools
- Nginx → Web server utama untuk menangani koneksi HTTP dan menjalankan Basic Auth.
- PHP-FPM (php8.4-fpm) →Pemroses skrip PHP di backend, dihubungkan melalui socket `unix:/var/run/php/php8.4-fpm.sock`.
- Apache2-utils (htpasswd) → Digunakan untuk membuat dan mengelola file kredensial `.htpasswd` berisi hash username dan password.
- `.htpasswd` → File penyimpanan credential yang diverifikasi oleh Nginx untuk setiap permintaan masuk.

### Cara uji akses 
```
curl -u noldor:silvan http://10.81.2.2:8004
curl -u noldor:silvan http://10.81.2.3:8005
curl -u noldor:silvan http://10.81.2.4:8006
#coba untuk akses salah (tidak dapat menampilkan text)
curl -u noldor:1234 http://10.81.2.4:8006
```

- Testcase benar

<img width="749" height="75" alt="Screenshot 2025-11-02 155431" src="https://github.com/user-attachments/assets/24e90cec-a61c-4c52-83c7-abd970ad2426" />
<img width="705" height="73" alt="Screenshot 2025-11-02 155439" src="https://github.com/user-attachments/assets/2863ac98-d71d-4518-99ee-4924b9d5a2f2" />
<img width="718" height="45" alt="Screenshot 2025-11-02 155445" src="https://github.com/user-attachments/assets/587f59d7-7567-4078-9b4c-843caf0182c1" />
<img width="749" height="49" alt="Screenshot 2025-11-02 155450" src="https://github.com/user-attachments/assets/1e7f3d16-4cb8-40c1-8b7b-1bd3108edbbd" />

- Testcase salah karena password salah

<img width="726" height="182" alt="Screenshot 2025-11-02 155600" src="https://github.com/user-attachments/assets/3ebeb828-e1b6-4494-8d2e-8831b5d52b84" />

# 15

sistem Nginx di setiap worker PHP (Galadriel, Celeborn, dan Oropher) dimodifikasi agar dapat menampilkan alamat IP pengunjung asli yang mengakses situs. Untuk mencapainya, konfigurasi Nginx ditambahkan parameter `fastcgi_param HTTP_X_REAL_IP $remote_addr` yang berfungsi meneruskan IP pengunjung dari Nginx ke PHP-FPM.
File index.php juga diperbarui agar dapat menampilkan hostname, IP server, dan IP pengunjung secara dinamis menggunakan variabel `$_SERVER['HTTP_X_REAL_IP']`
Selain itu, konfigurasi tetap mempertahankan Basic HTTP Authentication (user: noldor, pass: silvan) untuk menjaga keamanan akses ke setiap worker.

### Tools
- Nginx → Web server utama untuk menangani koneksi HTTP dan menjalankan Basic Auth.
- PHP-FPM (php8.4-fpm) → Pemroses skrip PHP di backend, dihubungkan melalui socket 
- Basic Auth (.htpasswd) → Memberikan lapisan keamanan dengan autentikasi username dan password sebelum mengakses halaman.
- index.php → Menampilkan informasi identitas server (hostname, IP server) dan alamat IP pengunjung yang diteruskan oleh Nginx.
- Header `X-Real-IP` → Header tambahan yang membawa IP asli klien agar tidak tertukar dengan IP proxy atau load balancer.

### Cara uji akses 
```
curl -u noldor:silvan http://10.81.2.2:8004
curl -u noldor:silvan http://10.81.2.3:8005
curl -u noldor:silvan http://10.81.2.4:8006
```

<img width="741" height="507" alt="Screenshot 2025-11-02 155653" src="https://github.com/user-attachments/assets/dc310ad4-6263-4ee2-a320-36a6e67f9801" />

# 16

Pharazon dikonfigurasi sebagai **reverse proxy** berbasis Nginx untuk mengawasi tiga worker PHP (Galadriel, Celeborn, Oropher). Pada Pharazon dibuat upstream bernama **Kesatria_Lorien** yang berisi alamat backend (`10.81.2.2:8004`, `10.81.2.3:8005`, `10.81.2.4:8006`) dengan pengaturan `max_fails` dan `fail_timeout` untuk toleransi kegagalan. Semua permintaan ke `pharazon.<xxxx>.com` diteruskan ke upstream tersebut menggunakan algoritma default (round-robin).  

Pharazon juga meneruskan header otentikasi dasar yang dikirim klien (`Authorization`) ke backend sehingga worker PHP dapat memverifikasi kredensial yang sama; selain itu Pharazon meneruskan header terkait IP/forwarding (`X-Real-IP`, `X-Forwarded-For`) agar backend mengetahui alamat pengunjung asli.

### Cara uji akses 
```
for i in {1..6}; do curl -H "Connection: close" -u noldor:silvan http://pharazon.k35.com; echo "---"; done
```

<img width="1460" height="777" alt="Screenshot 2025-11-02 155749" src="https://github.com/user-attachments/assets/3d52f878-a517-4ddf-b0c0-e565baef43d3" />

# 17

Melakukan benchmark dari node client (`Miriel`) ke `pharazon.<xxxx>.com` (menggunakan Basic Auth `noldor:silvan`) untuk mengamati distribusi beban ke tiga worker PHP (Galadriel, Celeborn, Oropher). Kemudian mensimulasikan kegagalan satu worker (contoh: stop `nginx` di Galadriel) dan mengulangi benchmark untuk memastikan Pharazon men-skip backend yang down dan tetap melayani trafik melalui worker yang tersisa. Akhirnya, periksa log Pharazon untuk konfirmasi failover dan error.

### Cara uji akses untuk melihat hostname backend yang merespons
```
for i in {1..10}; do
  curl -H "Connection: close" -u noldor:silvan http://pharazon.k35.com 2>/dev/null | grep "Hostname";
done

```

<img width="837" height="925" alt="Screenshot 2025-11-02 155858" src="https://github.com/user-attachments/assets/6724af6c-b8c8-4da4-89fb-3af6afe4413c" />

- Waktu Galadriel runtuh
<img width="1547" height="234" alt="Screenshot 2025-11-02 155913" src="https://github.com/user-attachments/assets/67f1f64d-0047-45d7-bab7-196fcaf2c99c" />

- Waktu Galadriel sudah kembali
<img width="1553" height="232" alt="Screenshot 2025-11-02 155924" src="https://github.com/user-attachments/assets/e0659b40-16fd-4a56-8e13-bd8c3e9f6571" />

# 18

Palantir berperan sebagai pusat pengetahuan Númenor, sehingga konsistensi dan keamanan datanya sangat penting. Untuk menjamin ketersediaan dan ketahanan informasi, diterapkan **replikasi database Master–Slave** menggunakan **MariaDB**. Dalam arsitektur ini, **Palantir** berfungsi sebagai **Master**, tempat semua perubahan data dilakukan, sedangkan **Narvi** berfungsi sebagai **Slave**, yang otomatis menyalin seluruh perubahan dari Palantir secara real-time. Dengan mekanisme ini, apabila Palantir mengalami gangguan, Narvi tetap memiliki salinan identik dari seluruh data terbaru.

### Tools

- MariaDB Server -> Sistem manajemen basis data yang digunakan untuk menyimpan dan mereplikasi data antar node. 
- Binary Log (`log_bin`) -> File log di Master yang mencatat seluruh perubahan data (INSERT, UPDATE, DELETE) agar dapat dikirim ke Slave. 
- Relay Log -> Log di sisi Slave yang menyalin perintah dari Master sebelum dieksekusi secara lokal. 
- User Replikasi (`replica_user`) -> Akun khusus dengan hak akses `REPLICATION SLAVE`, digunakan oleh Slave untuk terhubung ke Master. 
- `server-id` -> Identitas unik untuk membedakan Master dan Slave pada sistem replikasi. 
- `SHOW MASTER STATUS` -> Menampilkan posisi log terkini di Master, sebagai acuan awal sinkronisasi Slave. 

### Hasil
Replikasi Master–Slave berhasil jika:
- Di Palantir: file binary log aktif (`mysql-bin.000001`).
- Di Narvi: status replikasi menunjukkan **IO dan SQL Running**.
- Data baru di Master langsung muncul di Slave tanpa intervensi manual.
 
- Pada Pharazon
  
<img width="664" height="385" alt="Screenshot 2025-11-02 160110" src="https://github.com/user-attachments/assets/e29555d3-f9f3-48a1-a62f-0ba766e44213" />
<img width="622" height="195" alt="Screenshot 2025-11-03 234949" src="https://github.com/user-attachments/assets/0d615ea8-e3b4-4e26-ad17-a1fe98057e4f" />

# 19

Rate limiting diimplementasikan pada kedua node load balancer (Elros dan Pharazon) menggunakan modul `limit_req` Nginx. Mekanisme menggunakan `limit_req_zone` untuk menyimpan state per IP (`$binary_remote_addr`) dalam memory zone, lalu `limit_req` pada `location` block untuk menegakkan batas. Parameter `burst` dan `nodelay` mengatur toleransi spike singkat dan apakah permintaan ekstra ditunda atau langsung ditolak.

### Periksa access.log
```
grep ' 429 ' /var/log/nginx/access.log | tail -20
```
<img width="700" height="916" alt="Screenshot 2025-11-03 235043" src="https://github.com/user-attachments/assets/4d4dcea5-53de-408f-a0b3-6ea3645f399f" />
<img width="911" height="341" alt="Screenshot 2025-11-03 234923" src="https://github.com/user-attachments/assets/daf5af5f-d533-4d00-96f0-fc96e29c82ee" />



