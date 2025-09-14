FROM debian:bookworm

RUN apt-get update && apt-get install -y wget

RUN mkdir -p /var/www/html/adminer

RUN wget https://www.adminer.org/latest.php -O /var/www/html/adminer/index.php

RUN chown -R www-data:www-data /var/www/html
