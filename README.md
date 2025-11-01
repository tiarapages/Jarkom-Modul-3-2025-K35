# Jarkom-Modul-3-2025-K35

| Nama | NRP |
|---|---|
| Tiara Putri Prasetya | 5027241013 |
| Naufal Ardhana | 5027241118 |

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

<img width="1061" height="816" alt="image" src="https://github.com/user-attachments/assets/bdfe3ab2-d656-4838-9aa8-6c8c4060098e" />

# 2
> Raja Pelaut Aldarion, penguasa wilayah Númenor, memutuskan cara pembagian tanah client secara dinamis. Ia menetapkan:
-Client Dinamis Keluarga Manusia: Mendapatkan tanah di rentang [prefix ip].1.6 - [prefix ip].1.34 dan [prefix ip].1.68 - [prefix ip].1.94.
-Client Dinamis Keluarga Peri: Mendapatkan tanah di rentang [prefix ip].2.35 - [prefix ip].2.67 dan [prefix ip].2.96 - [prefix ip].2.121.
-Khamul yang misterius: Diberikan tanah tetap di [prefix ip].3.95, agar keberadaannya selalu diketahui. Pastikan Durin dapat menyampaikan dekrit ini ke semua wilayah yang terhubung dengannya.


Aldarion bertugas sebagai server DHCP pusat yang membagikan alamat IP secara dinamis ke seluruh klien dari dua keluarga besar (Manusia dan Peri) serta memberikan alamat IP statis kepada Khamul.
Sementara itu, Durin berperan sebagai DHCP Relay Agent — ia meneruskan semua permintaan DHCP dari klien di jaringan lain agar dapat diterima dan direspons oleh server DHCP di Aldarion.

### Alur Komunikasi DHCP

- Klien di jaringan lokal (Manusia, Peri, atau Khamul) mengirim paket DHCPDISCOVER (broadcast) untuk meminta IP.

- Jika klien berada di jaringan yang tidak langsung terhubung ke Aldarion, paket tersebut diterima oleh Durin dan diteruskan (forwarded) ke Aldarion melalui IP 10.81.4.4.

- Aldarion merespons dengan DHCPOFFER, yang dikirim kembali melalui Durin ke klien.

- Setelah klien menerima IP, komunikasi berlanjut normal, dan setiap klien berada di subnet yang sesuai dengan ketetapan Aldarion.

- Pengujian `ip a` pada Khamul  
<img width="1327" height="230" alt="Screenshot 2025-10-29 025737" src="https://github.com/user-attachments/assets/9699966f-7ecb-4411-b019-7b4681ea72f8" />

- Pengujian `ip a` pada Gilgalad  
<img width="1215" height="213" alt="Screenshot 2025-10-29 025751" src="https://github.com/user-attachments/assets/f14c3915-2c41-43b2-8094-261685fcf03b" />

- Pengujian `ip a` pada Amandil  
<img width="1542" height="285" alt="Screenshot 2025-10-29 025847" src="https://github.com/user-attachments/assets/03acf3e4-7f51-4c6d-81f4-1a29484f7acf" />



# 3

 > Untuk mengontrol arus informasi ke dunia luar (Valinor/Internet), sebuah menara pengawas, Minastir didirikan. Minastir mengatur agar semua node (kecuali Durin) hanya dapat mengirim pesan ke luar Arda setelah melewati pemeriksaan di Minastir.


Minastir berfungsi sebagai DNS relay (menara pengawas) yang mengontrol dan meneruskan permintaan DNS dari node-node internal (seperti Khamul, Gilgalad, dan Amandil) ke dunia luar (Internet / Valinor). Semua lalu lintas DNS dari Arda harus melewati Minastir sebelum keluar.

### Uji Berhasil

Saat perintah ip a di Khamul, Gilgalad, dan Amandil tetap menampilkan IP lokal masing-masing, tetapi ping google.com berhasil, itu artinya mereka berhasil keluar melalui Minastir sebagai pengawas DNS.
<img width="1192" height="170" alt="image" src="https://github.com/user-attachments/assets/a1b90847-b729-43db-8a5c-270376884e6a" />

# 4

> Ratu Erendis, sang pembuat peta, menetapkan nama resmi untuk wilayah utama (<xxxx>.com). Ia menunjuk dirinya (ns1.<xxxx>.com) dan muridnya Amdir (ns2.<xxxx>.com) sebagai penjaga peta resmi. Setiap lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher) diberikan nama domain unik yang menunjuk ke lokasi fisik tanah mereka. Pastikan Amdir selalu menyalin peta (master-slave) dari Erendis dengan setia.

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

> Untuk memudahkan, nama alias www.<xxxx>.com dibuat untuk peta utama <xxxx>.com. Reverse PTR juga dibuat agar lokasi Erendis dan Amdir dapat dilacak dari alamat fisik tanahnya. Erendis juga menambahkan pesan rahasia (TXT record) pada petanya: "Cincin Sauron" yang menunjuk ke lokasi Elros, dan "Aliansi Terakhir" yang menunjuk ke lokasi Pharazon. Pastikan Amdir juga mengetahui pesan rahasia ini.

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

# 6
Konfigurasi di aldarion `nano /etc/dhcp/dhcpd.conf`
Lakukan beberapa perubahan 
```
default-lease-time 600;  # Biarkan ini atau hapus
max-lease-time 3600;     # <-- UBAH INI (dari 7200)
```
Tambahkan default time di masing masing node manusia dan peri
```
default-lease-time 1800;   # 30 menit
max-lease-time 3600;       # 1 jam
```
restart dhcp `/etc/init.d/isc-dhcp-server restart`

# 7
jalankan update dan install
```
apt update
apt install -y php8.4 php8.4-cli php8.4-fpm php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip php8.4-sqlite3 php8.4-mysql nginx git unzip curl
apt install -y nginx
```
install composer 
```
curl -sS https://getcomposer.org/installer | php
cd .. /root
mv composer.phar /usr/local/bin/composer
cd /var/www
```
Jika masih error jalankan
```
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer --version
```
clone github api dari laravel
```
cd /var/www
git clone https://github.com/elshiraphine/laravel-simple-rest-api laravel
cd laravel
```
Install laravel dependencies
```
composer clear-cache
composer config platform.php 8.2.0
composer update --no-scripts
composer install
```
copy file environment
```
cp .env.example .env
php artisan key:generate
```
Atur permission di chown
```
chown -R www-data:www-data /var/www/laravel
chmod -R 755 /var/www/laravel
```
Configurasi nginx laravel
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
Aktifkan situs nginx dan hapus default
```
ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
service nginx restart
service php8.4-fpm restart
```
Uji di node lain
```
apt install lynx -y
lynx http://10.81.1.2
lynx http://10.81.1.3
lynx http://10.81.1.4
```
<img width="818" height="410" alt="image" src="https://github.com/user-attachments/assets/fb7b3a11-c5a6-4347-955f-29de2a59e689" />

# 8
Dalam Palantir download maria-db
```
apt update -y
apt install -y mariadb-server
service mariadb start
```
buat user
```
mysql -u root
CREATE DATABASE laravel_db;
CREATE USER 'root'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON laravel_db.* TO 'root'@'%';
FLUSH PRIVILEGES;
EXIT;
```
edit konfigurasi `nano /etc/mysql/mariadb.conf.d/50-server.cnf` dan rubah bagian `bind-address = 0.0.0.0` dan lanjutkan restart mariadb `service mariadb restart`





