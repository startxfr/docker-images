FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY apache_run.sh /bin/
RUN yum -y install httpd \
    && yum clean all \
    && mkdir -p /var/www/html \
    && mkdir -p /var/log/httpd \
    && chmod ug+rx /bin/apache_*
COPY welcome.html /var/www/html/index.html

EXPOSE 80
EXPOSE 443

CMD ["/bin/apache_run.sh"]
ONBUILD CMD ["/bin/apache_run.sh"]