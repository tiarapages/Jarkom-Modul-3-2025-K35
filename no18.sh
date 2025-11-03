# Install MariaDB di Palantir

apt update
apt install mariadb-server mariadb-client -y

service mariadb start
# Edit Konfigurasi MariaDB untuk Master

nano /etc/mysql/mariadb.conf.d/50-server.cnf

# Tambahkan di bagian [mysqld]:
[mysqld]
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog_format = ROW
bind-address = 0.0.0.0

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

mysql

#BUAT DATABASE DAN USER REPLIKASI
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root123');
CREATE USER 'replicator'@'%' IDENTIFIED BY 'replicator123';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;
# ada tabelnya file dan posisi nya catet
 EXIT;

### DI PALANTIR (Master) - Buat User Replikasi
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'replica_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;
EXIT;

# NARVI
apt update
apt install mariadb-server mariadb-client -y

service mariadb status
service mariadb start

mysql -u root -proot123
EXIT;

nano /etc/mysql/mariadb.conf.d/50-server.cnf

[mysqld]
server-id = 2
log_bin = /var/log/mysql/mysql-bin.log
binlog_format = ROW
bind-address = 0.0.0.0
relay-log = /var/log/mysql/mysql-relay-bin

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

service mariadb restart

service mariadb status

#LOGIN DI NARVI (SLAVE)
mysql -u root -proot123

STOP SLAVE;

CHANGE MASTER TO
  MASTER_HOST='10.81.4.3',
  MASTER_USER='replica_user',
  MASTER_PASSWORD='replica_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=328;

# MASTER_LOG_FILE → hasil SHOW MASTER STATUS; di Palantir
#MASTER_LOG_POS → hasil SHOW MASTER STATUS; di Palantir
START SLAVE;

SHOW SLAVE STATUS\G
# pastikan Slave_IO_Running: Yes dan Slave_SQL_Running: Yes

# TEST di palantir (master)
mysql -u root -proot123

CREATE DATABASE test_replication;
USE test_replication;
CREATE TABLE heroes (id INT PRIMARY KEY, name VARCHAR(50));
INSERT INTO heroes VALUES (1, 'Aragorn'), (2, 'Legolas');

# CEK DI NARVI (SLAVE)
mysql -u root -proot123

USE test_replication;
SELECT * FROM heroes;
