FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 30 \
    -subj "/C=MO/ST=CA/L=CA/O=42/OU=42/CN=42.fr" \
    -keyout /etc/nginx/ssl/incep.key -out /etc/nginx/ssl/incep.crt 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]