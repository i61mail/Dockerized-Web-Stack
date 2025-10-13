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

adshell:
	@docker exec -it adminer bash

rcshell:
	@docker exec -it redis bash

ftpshell:
	@docker exec -it ftp bash

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

adlogs:
	@$(DOCKER_COMPOSE) logs adminer

rclogs:
	@$(DOCKER_COMPOSE) logs redis

ftplogs:
	@$(DOCKER_COMPOSE) logs ftp

re: fclean all

freshbuild: fclean
	@$(DOCKER_COMPOSE) build --no-cache