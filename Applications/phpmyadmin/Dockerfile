FROM startx/sv-php
MAINTAINER Chistophe LARUE <dev@startx.fr>

RUN yum -y update && yum clean all
RUN yum -y install phpMyAdmin && yum clean all
ADD config.inc.php /etc/phpMyAdmin/config.inc.php
ADD test.php /var/www/html/test.php

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apachectl", "-D FOREGROUND"]