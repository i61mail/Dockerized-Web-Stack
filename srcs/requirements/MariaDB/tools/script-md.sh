#!/bin/bash

mysqld_safe --datadir='/var/lib/mysql' &
MYSQL_PID=$!

sleep 5

mysql -e "CREATE DATABASE IF NOT EXISTS $DATA_BASE;"
mysql -e "CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $DATA_BASE.* TO '$USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"

kill $MYSQL_PID
wait $MYSQL_PID 2>/dev/null || true  # the wait should be removed

# mariab-admin -u root -p"4545" shutdown

exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0