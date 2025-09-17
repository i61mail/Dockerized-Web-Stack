FROM debian:bookworm

RUN apt-get update && apt-get install -y redis-server

COPY ./conf/redis_cache.conf /etc/redis/redis_cache.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis_cache.conf"]