COMPOSE_FILE=docker_compose.yml
ENV_FILE=.env

NAME=WORDPRESS_APP

SHELL := /bin/bash
.ONESHELL:

all: $(NAME)

$(NAME): $(COMPOSE_FILE) $(ENV_FILE)
	docker compose -f $(COMPOSE_FILE) up -d
clean:
	docker compose -f $(COMPOSE_FILE) down

re: fclean $(NAME)

fclean: clean
	source .env
	- sudo chown -R $$(whoami):$$(whoami) $$DB_VOLUME_PATH
	- sudo chmod -R u+rwX "$$DB_VOLUME_PATH"
	- sudo rm -rf "$$DB_VOLUME_PATH/"*
	- docker stop $$(docker ps -aq)
	- docker rm $$(docker ps -aq)
	- docker rmi -f $$(docker images -aq)
	- docker system prune -a --volumes -f

.PHONY: fclean re clean
