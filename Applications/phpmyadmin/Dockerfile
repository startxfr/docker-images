FROM startx/sv-php:fc22
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install phpMyAdmin \
    && yum clean all
COPY config.php /etc/phpMyAdmin/config.inc.php
COPY test.php /var/www/html/test.php

EXPOSE 80
EXPOSE 443
VOLUME ["/var/www/html", "/var/log/httpd"]
CMD ["/sx/httpd_run.sh"]
