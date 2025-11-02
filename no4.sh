# erendis

nano /root/.bashrc
echo nameserver 10.81.5.2 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

ln -s /etc/init.d/named /etc/init.d/bind9

nano /etc/bind/named.conf.local


//
// Do any local configuration here
//
zone "k35.com" {
        type master;
        file "/etc/bind/zones/k35.com";
};

-mkdir /etc/bind/zones
-nano /etc/bind/zone.template
-cp /etc/bind/zone.template /etc/bind/zones/k35.com
s
-nano /etc/bind/zones/k35.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     k35.com. root.k35.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
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


service bind9 restart

# miriel
nano /etc/resolv.conf

nameserver 10.81.3.3
 nameserver 10.81.3.2
 nameserver 10.81.5.2

#uji
ping k35.com
ping ns1.k35.com
ping ns2.k35.com
ping  anarion.k35.com # semua di Client

# konfigurasi di aldarion
echo 'nameserver 10.81.3.3
 nameserver 10.81.3.2
 nameserver 10.81.5.2'
> /etc/resolv.conf

