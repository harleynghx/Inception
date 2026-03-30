FROM debian:bullseye

# Install PHP-FPM, PHP-MySQL (to talk to the database), and curl
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl php7.4-fpm php-mysql mariadb-client

# Download WP-CLI and make it executable
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM normally listens on a local "socket". 
# We need to change it to listen on port 9000 so NGINX can send traffic to it.
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Create the folder where PHP-FPM runs
RUN mkdir -p /run/php

# Copy the setup script
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# NGINX needs to talk to this container on port 9000
EXPOSE 9000

# Set the working directory to our mounted volume
WORKDIR /var/www/html

# Run the setup script
CMD ["/usr/local/bin/setup.sh"]