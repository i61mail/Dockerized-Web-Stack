FROM debian:bookworm

RUN apt-get update && apt-get install -y curl php php-fpm php-mysql wget unzip mariadb-client

COPY ./tools/wordpress_conf.sh /usr/local/bin/wordpress_conf.sh

RUN chmod +x /usr/local/bin/wordpress_conf.sh

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["/usr/local/bin/wordpress_conf.sh"]

CMD ["php-fpm8.2", "-F"]