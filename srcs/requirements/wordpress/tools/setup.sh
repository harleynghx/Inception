#!/bin/bash

# Give MariaDB a few seconds to fully boot up before trying to connect
sleep 10

# Ensure we are in the correct directory before checking for the config file
cd /var/www/html || exit

# Check if WordPress is already downloaded to avoid reinstalling on every restart
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create --dbname=${SQL_DATABASE} \
                     --dbuser=${SQL_USER} \
                     --dbpass=${SQL_PASSWORD} \
                     --dbhost=mariadb \
                     --allow-root

    echo "Installing WordPress..."
    wp core install --url=${WP_URL} \
                    --title="${WP_TITLE}" \
                    --admin_user=${WP_ADMIN_USER} \
                    --admin_password=${WP_ADMIN_PASSWORD} \
                    --admin_email=${WP_ADMIN_EMAIL} \
                    --allow-root

    echo "Creating a second standard user..."
    wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --allow-root
fi

echo "WordPress setup complete! Starting PHP-FPM..."

# Ensure proper permissions so that www-data can write to the WordPress files
chown -R www-data:www-data /var/www/html

# Start PHP-FPM in the foreground to keep the container alive
exec /usr/sbin/php-fpm7.4 -F