DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
WP_DATA_PATH = /home/isrkik/data/wp_data
DB_DATA_PATH = /home/isrkik/data/wp_db_data

all: create-dirs
	@$(DOCKER_COMPOSE) up -d --build

create-dirs:
	@mkdir -p $(WP_DATA_PATH)
	@mkdir -p $(DB_DATA_PATH)

fclean:
	@$(DOCKER_COMPOSE) down -v
	@docker image prune -a -f
	@rm -rf $(WP_DATA_PATH)/* $(DB_DATA_PATH)/* 2>/dev/null

ngshell:
	@docker exec -it nginx bash

wpshell:
	@docker exec -it wordpress bash

mdbshell:
	@docker exec -it mariadb bash

siteshell:
	@docker exec -it website bash

cvshell:
	@docker exec -it cadvisor bash

nglogs:
	@$(DOCKER_COMPOSE) logs nginx

wplogs:
	@$(DOCKER_COMPOSE) logs wordpress

mdlogs:
	@$(DOCKER_COMPOSE) logs mariadb

sitelogs:
	@$(DOCKER_COMPOSE) logs website

cvlogs:
	@$(DOCKER_COMPOSE) logs cadvisor

re: fclean all

freshbuild: fclean
	@$(DOCKER_COMPOSE) build --no-cache