#!/bin/bash

# Give MariaDB a few seconds to fully boot up before trying to connect
sleep 10

# Check if WordPress is already downloaded to avoid reinstalling on every restart
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    # Download the core files
    wp core download --allow-root

    echo "Creating wp-config.php..."
    # Link it to the database using your .env variables
    wp config create --dbname=${SQL_DATABASE} \
                     --dbuser=${SQL_USER} \
                     --dbpass=${SQL_PASSWORD} \
                     --dbhost=mariadb \
                     --allow-root

    echo "Installing WordPress..."
    # Run the famous "5-minute install" instantly
    wp core install --url=${WP_URL} \
                    --title="${WP_TITLE}" \
                    --admin_user=${WP_ADMIN_USER} \
                    --admin_password=${WP_ADMIN_PASSWORD} \
                    --admin_email=${WP_ADMIN_EMAIL} \
                    --allow-root

    echo "Creating a second standard user..."
    # Create a normal user (Subject requirement)
    wp user create standarduser standarduser@student.42.fr --user_pass=standardpassword --role=author --allow-root
fi

echo "WordPress setup complete! Starting PHP-FPM..."

# Start PHP-FPM in the foreground to keep the container alive
exec /usr/sbin/php-fpm7.4 -F