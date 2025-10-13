FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd vim

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/ftp.sh /ftp.sh

RUN chmod +x /ftp.sh

EXPOSE 21 21000-21010

ENTRYPOINT ["/ftp.sh"]
