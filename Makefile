COMPOSE_FILE=srcs/docker_compose.yml
ENV_FILE=srcs/.env
SECRETS  = ./secrets/wp_admin_password.txt ./secrets/wp_user_password.txt ./secrets/db_password.txt ./secrets/db_root_password.txt

SHELL := /bin/bash

.ONESHELL:

secrets:
	mkdir -p secrets

%.txt: secrets
	openssl rand -base64 33 > $@

all: up

up: $(SECRETS) $(COMPOSE_FILE) $(ENV_FILE)
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

re: fclean $(NAME)

fclean: down
	- docker system prune -a --volumes -f

.PHONY: fclean re down up
