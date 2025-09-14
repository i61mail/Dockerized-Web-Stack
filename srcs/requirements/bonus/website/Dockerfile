FROM debian:bookworm

RUN apt-get update

COPY ./website.sh /website.sh

RUN chmod +x /website.sh

ENTRYPOINT ["./website.sh"]