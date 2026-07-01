NAME = inception

# Default target
all: clean-ports up

# Sweeps the host machine for any ghost processes blocking the web ports
clean-ports:
	@echo "Sweeping for hijacked ports..."
	@sudo systemctl stop nginx 2>/dev/null || true
	@sudo systemctl stop apache2 2>/dev/null || true
	@sudo lsof -t -i:443 | xargs -r sudo kill -9 || true
	@sudo lsof -t -i:80 | xargs -r sudo kill -9 || true

# Builds the infrastructure
up:
	@echo "Creating persistent volume directories..."
	@mkdir -p /home/hang/data/wordpress
	@mkdir -p /home/hang/data/mariadb
	@echo "Starting up the stack..."
	docker compose -f srcs/docker-compose.yml up -d --build

# Gracefully stops the containers without destroying data
down:
	@echo "Stopping containers..."
	docker compose -f srcs/docker-compose.yml down

# Tears down containers, networks, and images
clean: down
	@echo "Cleaning up Docker environment..."
	docker compose -f srcs/docker-compose.yml down --rmi all -v

# The nuclear option: destroys everything, including the persistent data on your host
fclean: clean
	@echo "Nuking all persistent data..."
	@sudo rm -rf /home/hang/data/wordpress/*
	@sudo rm -rf /home/hang/data/mariadb/*
	docker system prune -af --volumes

# Complete reset
re: fclean all

.PHONY: all clean-ports up down clean fclean re