FROM startx/fedora
MAINTAINER Chistophe LARUE <dev@startx.fr>

RUN yum -y update && yum clean all
RUN yum -y install httpd php php-pecl-mongo php-cli php-pear php-gd php-google-apiclient php-pecl-zip php-mcrypt php-tcpdf php-xml-5.5.18-1.fc20 php-mysqlnd php-soap php-pecl-jsonc php-pecl-xdebug php-pdo php-process php-common php-mbstring && yum clean all
ADD welcome_apache.html /var/www/html/index.html

EXPOSE 80

# avoid some issues observed with container restart 
RUN rm -rf /run/httpd/*

ENTRYPOINT ["/usr/sbin/apachectl", "-D FOREGROUND"]