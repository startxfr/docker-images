FROM startx/sv-apache:fc20
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && yum clean all  
# Copy application content
COPY app/* /var/www/html/
COPY httpd.conf /etc/httpd/conf.d/sx.conf
COPY php.ini /etc/php.d/sx.ini
RUN chmod ug+r /var/www/html/* \
    && chown -R apache:apache /var/www/html /var/log/httpd 

EXPOSE 80
EXPOSE 443
VOLUME ["/var/www/html", "/var/log/httpd"]
CMD ["/sx/httpd_run.sh"]
