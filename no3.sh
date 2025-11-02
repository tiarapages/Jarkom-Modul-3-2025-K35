# minastir -

nano /root/.bashrc

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt update && apt install bind9

nano /etc/bind/named.conf.options

options {
        directory "/var/cache/bind";
        forwarders {
    192.168.122.1;
};
dnssec-validation no;
allow-query{any;};
auth-nxdomain no;
listen-on-v6 { any; };
};

service bind9 restart

# Uji ke client misal miriel
nano /root/.bashrc
echo nameserver 10.81.5.2 > /etc/resolv.conf 


# restart lalu
 ping google.com
