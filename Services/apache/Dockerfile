FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install httpd && \
    dnf clean all 
ENV HTTPDCONF=/etc/httpd/conf.d/app.conf \
    STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs \
    APP_PATH=/app \
    DATA_PATH=/data
COPY httpd.conf $HTTPDCONF
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh /bin/sx-httpd.sh && \
    chmod ug+r $HTTPDCONF && \
    rm -f /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/welcome.conf && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH && \
    touch $STARTUPLOG
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh $APP_PATH/sx-httpd.sh && \
    chown -R apache:apache $APP_PATH $DATA_PATH $LOG_PATH && \
    rm -f /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf

EXPOSE 80 443
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]