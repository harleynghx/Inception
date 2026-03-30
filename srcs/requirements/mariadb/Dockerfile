FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server

# Allow MariaDB to accept connections from other containers (like WordPress)
RUN sed -i "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy our setup script into the container
COPY tools/setup.sh /usr/local/bin/setup.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/setup.sh

# Expose the standard MySQL port
EXPOSE 3306

# Run the setup script when the container starts
CMD ["/usr/local/bin/setup.sh"]