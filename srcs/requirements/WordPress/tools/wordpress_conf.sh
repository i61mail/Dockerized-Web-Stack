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

if [ ! -f "$WP_PATH/wp-load.php" ]; then
    echo "📥 WordPress not found or incomplete. Installing..."
    
    # Download to temp location first
    wget -q https://wordpress.org/latest.zip -O /tmp/wordpress.zip
    unzip -q /tmp/wordpress.zip -d /tmp/
    
    # Copy files to mounted volume
    cp -r /tmp/wordpress/* "$WP_PATH/"
    rm -rf /tmp/wordpress /tmp/wordpress.zip
    
    echo "✅ WordPress installed to mounted volume"
else
    echo "⚡ WordPress already exists in mounted volume"
fi

exec "$@"
