COMPOSE_FILE=srcs/docker_compose.yml
ENV_FILE=srcs/.env

NAME=WORDPRESS_APP

SHELL := /bin/bash

.ONESHELL:

all: $(NAME)

$(NAME): $(COMPOSE_FILE) $(ENV_FILE)
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

.PHONY: fclean re down
