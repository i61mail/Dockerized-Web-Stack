#!/bin/bash
set -e

# Path where WordPress will be installed
WP_PATH="/var/www/wordpress"

# Download WordPress if not already present
if [ ! -d "$WP_PATH" ]; then
    echo "📥 Downloading WordPress..."
    wget -q https://wordpress.org/latest.zip -O /tmp/wordpress.zip
    unzip -q /tmp/wordpress.zip -d /var/www/
    rm /tmp/wordpress.zip
    echo "✅ WordPress extracted to $WP_PATH"
else
    echo "⚡ WordPress already exists at $WP_PATH, skipping download."
fi

# Ensure correct permissions (Nginx/Apache/PHP needs these)
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# If wp-config.php doesn’t exist, create it from sample
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "⚙️ Setting up wp-config.php..."
    cp "$WP_PATH/wp-config-sample.php" "$WP_PATH/wp-config.php"
    sed -i "s/database_name_here/${DATA_BASE}/" "$WP_PATH/wp-config.php"
    sed -i "s/username_here/${USER}/" "$WP_PATH/wp-config.php"
    sed -i "s/password_here/${PASSWORD}/" "$WP_PATH/wp-config.php"
    sed -i "s/localhost/mariadb/" "$WP_PATH/wp-config.php"  # assuming your DB service name is mariadb
    echo "✅ wp-config.php configured."
fi

exec "$@"
