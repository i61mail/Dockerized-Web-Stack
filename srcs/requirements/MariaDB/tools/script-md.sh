#!/bin/bash

mysqld_safe --datadir='/var/lib/mysql' &
MYSQL_PID=$!

until mysqladmin ping -u root -p"$ROOT_PASSWORD" --silent; do
    sleep 1
done

mysql -u root -p"$ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${DATA_BASE}\`;"
mysql -u root -p"$ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '${USER}'@'%' IDENTIFIED BY '${PASSWORD}';"
mysql -u root -p"$ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${DATA_BASE}\`.* TO '${USER}'@'%';"
mysql -u root -p"$ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

kill $MYSQL_PID
wait $MYSQL_PID 2>/dev/null || true 

exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0