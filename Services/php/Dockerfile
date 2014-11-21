FROM startx/sv-apache:centos6
MAINTAINER Christophe LARUE <dev@startx.fr>

WORKDIR /src
RUN yum -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && yum clean all \
    && rm -rf /var/www/html \
    && ln -s /src /var/www/html
COPY index.php /src/index.php

CMD ["/bin/apache_run.sh"]