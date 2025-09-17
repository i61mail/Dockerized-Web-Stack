FROM debian:bookworm

RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php \
    php-mysql wget

RUN rm -f /var/www/html/index.html && wget https://www.adminer.org/latest.php -O /var/www/html/index.php \
    && chown -R www-data:www-data /var/www/html

CMD ["apache2ctl", "-D", "FOREGROUND"]
