FROM startx/sv-apache:fc22
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && dnf clean all  
ENV LOG_PATH=/data/logs/apache_php  \
    APP_PATH=/data/apache_php \
    STARTUPLOG=/data/logs/apache_php/startup.log
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY run.sh /bin/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r $HTTPDCONF && \
    mkdir $APP_PATH && \
    mkdir $LOG_PATH && \
    touch $STARTUPLOG
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh && \
    chown -R apache:apache $APP_PATH $LOG_PATH && \
    chmod ug+r -R $APP_PATH

EXPOSE 80 443
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]
