# Developer Documentation

## Set Up the Environment
1. **Prerequisites:** 
   - A Linux environment (Debian/Ubuntu recommended).
   - `make`, `docker`, and `docker compose` must be installed.
   - You must have `sudo` privileges to modify the `/etc/hosts` file and create host directories.
2. **Configuration:** 
   - Ensure `srcs/.env` is correctly populated with all required environment variables.
   - Edit `/etc/hosts` to point `hang.42.fr` to `127.0.0.1`.
   ```bash
   sudo nano /etc/hosts
   # Add the line: 127.0.0.1 hang.42.fr
   ```

## Build and Launch the Project
The root `Makefile` orchestrates the entire build process.
- Run `make` to execute the default `all` rule. This will:
  1. Ensure no host processes are blocking ports 80/443.
  2. Create the necessary host directories (`/home/hang/data/wordpress` and `/home/hang/data/mariadb`).
  3. Execute `docker compose -f srcs/docker-compose.yml up -d --build`.

## Manage Containers and Volumes
- **View Logs:** `docker compose -f srcs/docker-compose.yml logs -f`
- **Execute into a running container:** `docker exec -it <container_name> bash`
- **List Volumes:** `docker volume ls`
- **Inspect a Volume:** `docker volume inspect srcs_wordpress_data`

## Project Data Storage and Persistence
Data persistence is achieved using Docker named volumes configured to bind to specific host directories:
- **MariaDB Database Files:** Stored persistently on the host at `/home/hang/data/mariadb` and mounted into the MariaDB container at `/var/lib/mysql`.
- **WordPress Core Files & Uploads:** Stored persistently on the host at `/home/hang/data/wordpress` and mounted into both the WordPress and NGINX containers at `/var/www/html`. 

Because these volumes are mapped to the host filesystem, the data persists even if the containers and networks are entirely removed using `make clean`. Data is only destroyed if the host directories are manually deleted (which is handled by `make fclean`).
