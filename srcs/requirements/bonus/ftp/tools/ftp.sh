#!/bin/bash

useradd -m user_ftp && echo "user_ftp:pw_ftp" | chpasswd

mkdir -p /home/user_ftp/uploads
chown user_ftp:user_ftp /home/user_ftp/uploads
chmod 755 /home/user_ftp/uploads

mkdir -p /var/run/vsftpd/empty && \
chmod 555 /var/run/vsftpd/empty && \
chown root:root /var/run/vsftpd/empty

exec vsftpd /etc/vsftpd.conf