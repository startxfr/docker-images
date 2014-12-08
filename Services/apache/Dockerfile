FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install packages and set up httpd
RUN yum -y install httpd \
    && yum clean all \
    && mkdir -p /var/www/html \
    && mkdir -p /var/log/httpd 
# Copy startx toolkit
COPY sx/* /sx/
COPY httpd.conf /etc/httpd/conf.d/sx.conf
# Copy html content
COPY html/* /var/www/html/
RUN chmod ug+rx /sx/httpd* \
    && chmod ug+r /var/www/html/* \
    && chown -R apache:apache /var/www/html /var/log/httpd 

EXPOSE 80
EXPOSE 443
VOLUME ["/var/www/html", "/var/log/httpd"]
CMD ["/sx/httpd_run.sh"]
