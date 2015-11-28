FROM startx/sv-apache
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && dnf clean all  
COPY httpd.conf /etc/httpd/conf.d/app.conf
COPY php.ini /etc/php.d/sx.ini
COPY run.sh /bin/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r /etc/httpd/conf.d/app.conf
COPY ./ /data/www
RUN rm -f /data/www/Dockerfile /data/www/httpd.conf /data/www/run.sh && \
    chown -R apache:apache /data/www /data/logs && \
    chmod ug+r -R /data/www

EXPOSE 80
EXPOSE 443
VOLUME ["/data/www","/data/logs"]
CMD ["/bin/run.sh"]