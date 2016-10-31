FROM startx/sv-apache:fc22
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install php php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy \
    && dnf clean all
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY run.sh /bin/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r $HTTPDCONF
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh && \
    chown -R apache:apache $DATA_PATH $APP_PATH $LOG_PATH && \
    chmod ug+r -R $DATA_PATH $APP_PATH

EXPOSE 80 443
CMD [ "/bin/run.sh" ]
