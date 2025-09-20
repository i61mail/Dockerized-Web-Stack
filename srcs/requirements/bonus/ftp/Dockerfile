FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd vim

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

RUN useradd -m user_ftp && echo "user_ftp:pw_ftp" | chpasswd

RUN mkdir -p /var/run/vsftpd/empty && \
    chmod 555 /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty

EXPOSE 21 21000-21010

CMD ["vsftpd", "/etc/vsftpd.conf"]
