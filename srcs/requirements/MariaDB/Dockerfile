FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

COPY ./tools/script-md.sh /script-md.sh

RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /script-md.sh

ENTRYPOINT ["./script-md.sh"]
