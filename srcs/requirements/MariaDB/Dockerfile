FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./tools/script-md.sh /script-md.sh

RUN chmod +x /script-md.sh

ENTRYPOINT ["./script-md.sh"]