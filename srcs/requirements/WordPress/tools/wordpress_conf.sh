#!/bin/bash

WP_PATH="/var/www/wordpress"

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo ">> Setting up WordPress..."

    wp core download --path="$WP_PATH" --allow-root

    wp core config \
        --path="$WP_PATH" \
        --dbhost="mariadb:3306" \
        --dbname="$DATA_BASE" \
        --dbuser="$USER" \
        --dbpass="$PASSWORD" \
        --allow-root

    wp core install \
        --path="$WP_PATH" \
        --url="$DOMAIN_NAME" \
        --title="$TITLE" \
        --admin_user="$ADMIN_NAME" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_MAIL" \
        --allow-root

    wp user create --path="$WP_PATH" "$USER_NAME" "$USER_MAIL" \
        --user_pass="$USER_PASSWORD" \
        --role="$USER_ROLE" \
        --allow-root
fi

chown -R www-data:www-data "$WP_PATH"

exec php-fpm8.2 -F