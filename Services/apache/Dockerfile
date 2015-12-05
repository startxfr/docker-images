FROM startx/fedora:23
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install httpd && \
    dnf clean all 
ENV HTTPDCONF=/etc/httpd/conf.d/app.conf \
    STARTUPLOG=/data/logs/apache/startup.log \
    LOG_PATH=/data/logs/apache  \
    APP_PATH=/data/apache
COPY httpd.conf $HTTPDCONF
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh /bin/sx-httpd.sh && \
    chmod ug+r $HTTPDCONF && \
    rm -f /etc/httpd/conf.d/autoindex.conf && \
    rm -f /etc/httpd/conf.d/welcome.conf && \
    mkdir -p $APP_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh $APP_PATH/sx-httpd.sh && \
    chown -R apache:apache $APP_PATH $LOG_PATH

EXPOSE 80 443
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]
