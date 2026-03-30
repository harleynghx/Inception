FROM debian:bullseye

# Install NGINX and OpenSSL
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

# Create the folder for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
# -subj fills in the 'Country', 'State', 'Login', etc., automatically
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MY/ST=Selangor/L=ShahAlam/O=42/OU=42/CN=hang.42.fr/UID=hang"

# Copy our configuration file into the container
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Start NGINX in the foreground (Docker requirement)
CMD ["nginx", "-g", "daemon off;"]