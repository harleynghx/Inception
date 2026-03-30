#!/bin/bash

# Start the service temporarily so we can configure it
service mariadb start
sleep 5

# Create the database and the user, and grant privileges safely
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shut down the temporary service securely
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB in the foreground so Docker can keep the container alive
exec mysqld_safe