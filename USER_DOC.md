# User Documentation

## Services Provided
This stack provides a fully functional WordPress website served securely over HTTPS. It consists of:
- **NGINX:** A web server acting as the only entrypoint to the infrastructure, handling SSL/TLS encryption.
- **WordPress:** The content management system (CMS) running on PHP-FPM to dynamically generate web pages.
- **MariaDB:** The database backend storing all WordPress data (users, posts, settings).

## Start and Stop the Project
- **To start the project:** Run `make` or `make up` in the root directory.
- **To stop the project:** Run `make down` to gracefully stop the containers without losing data.
- **To clean the project (remove containers/networks):** Run `make clean`.
- **To completely reset (nuclear option, deletes data):** Run `make fclean`.

## Accessing the Website
- **Website:** Open your web browser and navigate to `https://hang.42.fr`. Note: Since a self-signed certificate is used, your browser will display a security warning. You will need to explicitly accept the risk to proceed.
- **Administration Panel:** Navigate to `https://hang.42.fr/wp-admin` and log in with your administrator credentials.

## Locate and Manage Credentials
All credentials, database names, and user configurations are managed centrally in the `.env` file located at `srcs/.env`. 
If you need to change passwords or usernames, modify this file *before* building the project for the first time. If the database has already been initialized, changing the `.env` file will require an `fclean` to reset the database and apply the new credentials.

## Check Services are Running Correctly
You can verify the status of the services by running:
```bash
docker compose -f srcs/docker-compose.yml ps
```
All containers (`nginx`, `wordpress`, `mariadb`) should have a status of `Up`. If a container is restarting or exited, you can check its logs for errors:
```bash
docker logs <container_name>
```
