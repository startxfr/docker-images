FROM startx/sv-apache:centos6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install php php-pecl-mongo php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap php-pecl-xdebug \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-pecl-zip php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && yum clean all  
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY run.sh /bin/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r $HTTPDCONF
COPY ./ $TMP_APP_PATH
RUN rm -f $TMP_APP_PATH/Dockerfile $TMP_APP_PATH/httpd.conf $TMP_APP_PATH/run.sh && \
    chown -R apache:apache $TMP_APP_PATH $APP_PATH $LOG_PATH && \
    chmod ug+r -R $TMP_APP_PATH $APP_PATH

EXPOSE 80 443
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]
