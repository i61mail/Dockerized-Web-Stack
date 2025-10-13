FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -subj "/C=MO/ST=CA/O=42/CN=isrkik.42.fr" \
    -keyout /etc/nginx/ssl/incep.key -out /etc/nginx/ssl/incep.crt 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]