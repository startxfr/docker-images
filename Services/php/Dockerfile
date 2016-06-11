FROM startx/sv-apache
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && dnf clean all  
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY run.sh /bin/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r $HTTPDCONF  && \
    mkdir /etc/httpd/logs &> /dev/null && \
    chown -R apache:apache /etc/httpd/logs &> /dev/null
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh && \
    chown -R apache:apache $DATA_PATH $APP_PATH $LOG_PATH && \
    chmod ug+r -R $DATA_PATH $APP_PATH

EXPOSE 80 443
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]