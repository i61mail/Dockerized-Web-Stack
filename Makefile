all:
	docker compose -f srcs/docker-compose.yml up -d --build
clean:
	docker compose -f srcs/docker-compose.yml down -v
fclean:
	docker compose -f srcs/docker-compose.yml down -v \
	&& docker image prune -a -f
re: fclean all