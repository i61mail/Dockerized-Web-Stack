FROM debian:bookworm

RUN apt-get update && apt-get install -y curl php php-fpm php-mysql php-redis

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

COPY ./tools/wordpress_conf.sh /wordpress_conf.sh

RUN chmod +x /wordpress_conf.sh

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["/wordpress_conf.sh"]