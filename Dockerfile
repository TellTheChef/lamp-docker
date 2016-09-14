FROM tellthechef/lamp-docker
MAINTAINER Matej Kramny <matej@matej.me>

RUN apt-get update && apt-get install -y apt-transport-https curl git python-setuptools

# add filebeat repo
ADD conf/elasticsearch.gpg /tmp/elasticsearch.gpg
RUN cat /tmp/elasticsearch.gpg | apt-key add -
RUN echo "deb https://packages.elastic.co/beats/apt stable main" | tee -a /etc/apt/sources.list.d/beats.list

RUN apt-get update

RUN apt-get install -y filebeat
RUN apt-get remove -y postfix rsyslog supervisor

ADD conf/httpd.conf /etc/apache2/apache2.conf
ADD conf/php.ini /etc/php5/apache2/php.ini
ADD conf/lamp.sh /etc/lamp.sh

RUN chmod +x /etc/lamp.sh

RUN apachectl configtest
RUN rm -rf /var/www

RUN service apache2 stop
RUN service filebeat stop

EXPOSE 80
EXPOSE 443

CMD ["/etc/lamp.sh"]
