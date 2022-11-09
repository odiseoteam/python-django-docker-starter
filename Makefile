DOCKER_COMPOSE=docker compose --env-file=.env.docker
TERM_LINES=$(shell tput lines)
TERM_COLS=$(shell tput cols)

.PHONY: all build ssh logs install

ssh:
	$(DOCKER_COMPOSE) exec django sh

build:
	$(DOCKER_COMPOSE) build django

up:
	$(DOCKER_COMPOSE) up -d --remove-orphans

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs django --follow
