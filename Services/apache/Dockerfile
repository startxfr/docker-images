FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

# Install packages and set up httpd
RUN yum -y install httpd \
    && yum clean all \
    && mkdir -p /var/www/html \
    && mkdir -p /var/log/httpd 
# Copy startx toolkit
COPY sx/* /sx/
# Copy html content
COPY html/* /var/www/html/
RUN chmod ug+rx /sx/httpd* \
    && chmod ug+r /var/www/html/*\
    && chmod ug+r /var/www/html/*

EXPOSE 80
EXPOSE 443
CMD ["/sx/httpd_run.sh"]