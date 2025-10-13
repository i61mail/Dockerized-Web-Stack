FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

RUN mkdir -p /usr/share/website

COPY ./index.html /usr/share/website

COPY ./conf/ng.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]