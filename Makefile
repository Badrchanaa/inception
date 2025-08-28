COMPOSE_FILE=srcs/docker_compose.yml
ENV_FILE=srcs/.env
SECRETS  = ./secrets/wp_admin_password.txt ./secrets/wp_user_password.txt ./secrets/db_password.txt ./secrets/db_root_password.txt

%.txt:
	openssl rand -base64 33 > $@

SHELL := /bin/bash

.ONESHELL:

all: up

up: $(SECRETS) $(COMPOSE_FILE) $(ENV_FILE)
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

re: fclean $(NAME)

fclean: down
	source srcs/.env
	if [[ -v DB_VOLUME_PATH ]] && [[ -v WP_VOLUME_PATH ]]; then
		- sudo chown -R $$(whoami):$$(whoami) $$DB_VOLUME_PATH
		- sudo chmod -R u+rwX "$$DB_VOLUME_PATH"
		- sudo rm -rf "$$DB_VOLUME_PATH/"*
		- sudo chown -R $$(whoami):$$(whoami) $$WP_VOLUME_PATH
		- sudo chmod -R u+rwX "$$WP_VOLUME_PATH"
		- sudo rm -rf "$$WP_VOLUME_PATH/"*
		- docker stop $$(docker ps -aq)
		- docker rm $$(docker ps -aq)
		- docker rmi -f $$(docker images -aq)
	fi
	# - docker system prune -a --volumes -f

.PHONY: fclean re down up
