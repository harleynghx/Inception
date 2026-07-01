*This project has been created as part of the 42 curriculum by hang.*

## Description
This project is an introduction to system administration using Docker. It aims to broaden your knowledge of system administration by virtualizing several Docker images in a personal virtual machine. The goal is to set up a small infrastructure composed of NGINX, WordPress with PHP-FPM, and MariaDB, all running in dedicated containers and connected via a Docker network.

## Instructions
To run this project:
1. Ensure Docker and Docker Compose are installed on your system.
2. Ensure you have configured your local hosts file (`/etc/hosts`) to point `hang.42.fr` to `127.0.0.1`.
3. At the root of the repository, run `make` or `make up` to build and start the containers.
4. The website will be accessible at `https://hang.42.fr`.

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/)
- [WordPress Documentation](https://wordpress.org/support/)
- **AI Usage:** AI was used as a learning assistant to clarify Docker concepts, troubleshoot Docker Compose volume syntax, and help generate the boilerplate for this documentation in accordance with the project requirements.

## Project description
This infrastructure leverages Docker to containerize services, isolating their dependencies and execution environments. 

### Virtual Machines vs Docker
Virtual Machines (VMs) include a full copy of an operating system, the application, necessary binaries, and libraries, taking up tens of GBs and requiring a hypervisor. Docker containers share the host OS kernel and isolate the application processes, making them significantly more lightweight, faster to start, and less resource-intensive.

### Secrets vs Environment Variables
Environment variables are often used to pass configuration data into containers. However, passing sensitive data (like passwords) via plain environment variables can expose them if the environment is inspected. Docker Secrets provides a more secure mechanism to manage sensitive data by mounting them as in-memory files within the container, preventing them from being exposed in environment variables or image layers. (Note: This project uses `.env` files as per the mandatory requirements, but secrets are recommended for production).

### Docker Network vs Host Network
Using the Host Network mode removes network isolation between the container and the Docker host, meaning the container shares the host's networking namespace. A Docker Network (like a bridge network used in this project) creates an isolated internal network for containers to communicate with each other securely using DNS resolution based on container names, without exposing their internal ports to the host by default.

### Docker Volumes vs Bind Mounts
Bind mounts map a specific file or directory on the host machine directly into a container. They depend on the directory structure of the host machine. Docker Volumes are entirely managed by Docker, providing a more abstracted, safer, and portable way to persist data independent of the host's specific file system structure. This project uses named volumes that are specifically configured to store data in the `/home/hang/data` directories to satisfy both Docker management and the subject's local storage requirements.
