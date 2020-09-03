openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=RU/ST=Moscow/L=Moscow/O=School_21/OU=21/CN=test"

service php7.3-fpm start
service nginx start
wait 10000
bash