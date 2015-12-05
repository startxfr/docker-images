FROM startx/sv-php
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN dnf -y install phpMyAdmin \
    && dnf clean all
COPY config.php /etc/phpMyAdmin/config.inc.php
COPY test.php /var/www/html/test.php

EXPOSE 80 443
VOLUME ["/var/www/html", "/var/log/httpd"]
CMD ["/sx/httpd_run.sh"]