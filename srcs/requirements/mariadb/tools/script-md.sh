#!/bin/bash

service mariadb start

sleep 5

mysql -e "CREATE DATABASE IF NOT EXISTS $DATA_BASE;"
mysql -e "CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $DATA_BASE.* TO '$USER'@'%';"

mysqladmin shutdown

exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0