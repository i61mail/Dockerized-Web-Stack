#!/bin/bash

WP_PATH="/var/www/wordpress"

if [ ! -f "$WP_PATH/wp-config.php" ]; then

    wp core download --path="$WP_PATH" --allow-root
    wp core config --path="$WP_PATH" --dbhost="mariadb:3306" \
        --dbname="$DATA_BASE" --dbuser="$USER" --dbpass="$PASSWORD" \
        --allow-root

    wp core install --path="$WP_PATH" --url="$DOMAIN_NAME" --title="$TITLE" \
        --admin_user="$ADMIN_NAME" --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_MAIL" --allow-root

    wp user create --path="$WP_PATH" "$USER_NAME" "$USER_MAIL" \
        --user_pass="$USER_PASSWORD" --role="$USER_ROLE" --allow-root

    wp config set WP_REDIS_HOST "$REDIS_CACHE_HOST" --allow-root --path="$WP_PATH"
    wp config set WP_REDIS_PORT "$REDIS_CACHE_PORT" --allow-root --path="$WP_PATH"
    wp plugin install redis-cache --activate --allow-root --path="$WP_PATH"
    wp redis enable --allow-root --path="$WP_PATH"
fi

chown -R www-data:www-data "$WP_PATH"
exec php-fpm8.2 -F 