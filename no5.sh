# erendis

nano /etc/bind/zones/k35.com

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

nano /etc/bind/zones/db.10.81.3

$TTL    604800
@       IN      SOA     k35.com. root.k35.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.k35.com.
@       IN      NS      ns2.k35.com.
; PTR Records untuk Erendis dan Amdir
2       IN      PTR     amdir.k35.com.
3       IN      PTR     erendis.k35.com.

sudo nano /etc/bind/named.conf.local

# tambahin di bawah sendiri

zone "3.81.10.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.10.81.3";
};

# Cek semua file konfigurasi di terminal Erendis:

named-checkconf
named-checkzone k35.com /etc/bind/zones/k35.com
named-checkzone 3.81.10.in-addr.arpa /etc/bind/zones/db.10.81.3

#restart

service bind9 restart

#uji di client

# 1.Cek alias `www`:

dig www.k35.com

# 2. Lacak Erendis dari IP-nya (Reverse PTR):

dig -x 10.81.3.3

# 3. Baca pesan rahasia Erendis (TXT Record):

dig TXT erendis.k35.com