FROM debian

RUN apt update -y

RUN apt upgrade -y

RUN apt install apache2 -y

RUN mkdir /etc/apache2/logs

COPY apache2.conf /etc/apache2/apache2.conf

COPY index.html /var/www/html/index.html

CMD [ "apache2" , "-DFOREGROUND" ]