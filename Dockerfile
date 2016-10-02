FROM tellthechef/lamp-docker
MAINTAINER Matej Kramny <matej@matej.me>

RUN apt-get remove -y postfix rsyslog supervisor

ADD conf/httpd.conf /etc/apache2/apache2.conf
ADD conf/php.ini /etc/php5/apache2/php.ini
ADD conf/lamp.sh /etc/lamp.sh
RUN chmod +x /etc/lamp.sh

RUN apachectl configtest
RUN rm -rf /var/www

RUN service apache2 stop

EXPOSE 80
EXPOSE 443

CMD ["/etc/lamp.sh"]
