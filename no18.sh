# Install MariaDB di Palantir

apt update
apt install mariadb-server mariadb-client -y

# Edit Konfigurasi MariaDB untuk Master

nano /etc/mysql/mariadb.conf.d/50-server.cnf

# ubah

bind-address = 0.0.0.0

# Tambahkan di bagian [mysqld]:
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog_do_db = palantir_db

# Ubah  biar dpt diakses

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chmod 755 /var/lib/mysql

# Restart MariaDB

service mariadb start
service mariadb status

# verif

ls -la /var/log/mysql/

#login

mysql -u root

#BUAT DATABASE DAN USER REPLIKASI

CREATE DATABASE palantir_db;
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'replica_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
SHOW DATABASES;

# exit

 EXIT;

### Narvi