FROM debian:buster

RUN apt-get update
RUN apt-get -y install openssl
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

WORKDIR /var/www/html/
ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz ./
RUN tar xf phpMyAdmin-5.0.2-english.tar.gz
RUN rm phpMyAdmin-5.0.2-english.tar.gz
ADD ./srcs/conf_php.inc.php phpmyadmin

ADD http://wordpress.org/latest.tar.gz ./
RUN tar xf latest.tar.gz
RUN rm latest.tar.gz
ADD ./srcs/wp-config.php ./wordpress

# RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout /etc/ssl/private/nginx-selfsigned.key \
# -out /etc/ssl/certs/nginx-selfsigned.crt \
# -subj "/C=RU/ST=Moscow/L=Moscow/O=School_42/OU=21/CN=test"

WORKDIR /
ADD ./srcs/nginx.conf /etc/nginx/sites-available/localhost
ADD ./srcs/nginx.conf /etc/nginx/sites-enabled/localhost

ADD ./srcs/* ./srcs/
CMD bash ./srcs/start.sh

EXPOSE 80
EXPOSE 433