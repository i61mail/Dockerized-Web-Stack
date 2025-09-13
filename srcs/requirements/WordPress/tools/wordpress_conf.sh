#!/bin/bash

WP_PATH="/var/www/wordpress"
until mysqladmin ping -h mariadb -u"$USER" -p"$PASSWORD" --silent; do
    echo "still waiting for MariaDB..."
    echo "Trying to connect with: mysqladmin ping -h mariadb -u$USER -p$PASSWORD"

    sleep 1
done
echo "✅ MariaDB is ready!"

# Install WordPress if not already present
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo ">> Setting up WordPress..."

    # Download WordPress core
    wp core download --path="$WP_PATH" --allow-root

    # Generate wp-config.php
    wp core config \
        --path="$WP_PATH" \
        --dbhost="mariadb:3306" \
        --dbname="$DATA_BASE" \
        --dbuser="$USER" \
        --dbpass="$PASSWORD" \
        --allow-root

    # Install WordPress
    wp core install \
        --path="$WP_PATH" \
        --url="$DOMAIN_NAME" \
        --title="$TITLE" \
        --admin_user="$ADMIN_NAME" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_MAIL" \
        --allow-root

    # Create extra user
    wp user create "$USER_NAME" "$USER_MAIL" \
        --user_pass="$USER_PASSWORD" \
        --role="$USER_ROLE" \
        --allow-root
fi

# Set ownership
chown -R www-data:www-data "$WP_PATH"

# Replace shell with PHP-FPM
exec php-fpm8.2 -F