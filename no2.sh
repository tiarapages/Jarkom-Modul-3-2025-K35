# Pada aldarion
apt-get install
apt-get install isc-dhcp-server -y

-nano /etc/default/isc-dhcp-server

INTERFACESv4="eth0"
INTERFACESv6=""

nano /etc/dhcp/dhcpd.conf

# keluarga manusia
subnet 10.81.1.0 netmask 255.255.255.0 {
    range 10.81.1.6 10.81.1.34;
    range 10.81.1.68 10.81.1.94;
    option routers 10.81.1.1;
    option broadcast-address 10.81.1.255;
}

# keluarga peri
subnet 10.81.2.0 netmask 255.255.255.0 {
    range 10.81.2.35 10.81.2.67;
    range 10.81.2.96 10.81.2.121;
    option routers 10.81.2.1;
    option broadcast-address 10.81.2.255;
}

# khamul
subnet 10.81.3.0 netmask 255.255.255.0 {
    range 10.81.3.94 10.81.3.96;
    option routers 10.81.3.1;
    option broadcast-address 10.81.3.255;
}
host Khamul {
    hardware ethernet 02:42:4d:bc:e6:00;
    fixed-address 10.81.3.95;
}
subnet 10.81.4.0 netmask 255.255.255.0 {
    range 10.81.4.94 10.81.4.96; #random
    option routers 10.81.4.1;
    option broadcast-address 10.81.4.255;
}



# Pada durin
apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start

nano /etc/default/isc-dhcp-relay

SERVERS="10.81.4.4"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=""

# restart

# aldarion
service isc-dhcp-server start
#durin
service isc-dhcp-relay start
