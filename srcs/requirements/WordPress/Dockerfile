FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm php-mysql \
        php-xml php-mbstring php-curl php-gd php-zip php-intl wget unzip

RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /var/www/ && \
    rm /tmp/wordpress.zip

RUN chown -R www-data:www-data /var/www/wordpress

RUN mkdir -p /run/php

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

RUN sed -i 's/listen = .*/listen = 9000/' /etc/php/*/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]