#!/bin/bash

WP_PATH="/var/www/wordpress"

if [ -d "$WP_PATH" ]; then
    wget -q https://wordpress.org/latest.zip -O /tmp/wordpress.zip
    unzip -q /tmp/wordpress.zip -d /var/www/
    rm /tmp/wordpress.zip
fi

chown -R www-data:www-data /var/www/wordpress
# chmod -R 755 /var/www/wordpress

exec "php-fpm8.2" "-F"
