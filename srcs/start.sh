openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=RU/ST=Moscow/L=Moscow/O=School_21/OU=21/CN=test"

service mysql start
service php7.3-fpm start
service nginx start

echo "DB SETUP RUNS"
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress .* TO 'admin'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

bash