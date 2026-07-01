#!/bin/bash

# Check if the database folder already exists
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Initializing database for the first time..."
    
    # Start the service temporarily
    service mariadb start
    sleep 5

    # Pass all commands through a single connection using a HereDoc
    mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # Shut down the temporary service securely
    mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
else
    echo "Database already exists, skipping initialization."
fi

# Start MariaDB in the foreground
exec mysqld_safe