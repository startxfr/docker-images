FROM startx/fedora
MAINTAINER Chistophe LARUE <dev@startx.fr>

RUN yum -y update && yum clean all
RUN yum -y install httpd php php-* && yum clean all
ADD welcome_apache.html /var/www/html/index.html

EXPOSE 80

# avoid some issues observed with container restart 
RUN rm -rf /run/httpd/*

ENTRYPOINT ["/usr/sbin/apachectl", "-D FOREGROUND"]