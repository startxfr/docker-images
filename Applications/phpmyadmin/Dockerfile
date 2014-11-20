FROM startx/sv-php:fc20
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install phpMyAdmin \
    && yum clean all
COPY config.inc.php /etc/phpMyAdmin/config.inc.php
COPY test.php /var/www/html/test.php

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/sbin/apachectl", "-D FOREGROUND"]