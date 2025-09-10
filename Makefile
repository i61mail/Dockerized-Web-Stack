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
	@docker exec -it WordPress bash

mdbshell:
	@docker exec -it MariaDB bash
nglogs:
	@$(DOCKER_COMPOSE) logs nginx

wplogs:
	@$(DOCKER_COMPOSE) logs wordpress

mdlogs:
	@$(DOCKER_COMPOSE) logs mariadb

re: fclean all