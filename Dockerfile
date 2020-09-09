FROM debian:buster

RUN apt-get update
RUN apt-get -y install openssl
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

WORKDIR /var/www/html/
ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz ./
RUN tar xf phpMyAdmin-5.0.2-english.tar.gz
RUN mv phpMyAdmin-5.0.2-english phpmyadmin
RUN rm phpMyAdmin-5.0.2-english.tar.gz

ADD http://wordpress.org/latest.tar.gz ./
RUN tar xf latest.tar.gz
RUN rm latest.tar.gz
ADD ./srcs/wp-config.php ./wordpress

WORKDIR /
ADD ./srcs/nginx.conf /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

ADD ./srcs/start.sh ./srcs/
ADD ./srcs/autoindex.sh ./srcs/
ENTRYPOINT bash ./srcs/start.sh

EXPOSE 80
EXPOSE 433