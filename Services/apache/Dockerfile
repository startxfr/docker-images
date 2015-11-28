FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install httpd && \
    dnf clean all 
ENV HTTPDCONF=/etc/httpd/conf.d/app.conf \
    STARTUPLOG=/data/logs/httpd/startup.log \
    LOG_PATH=/data/logs/httpd  \
    APP_PATH=/data/httpd
COPY httpd.conf $HTTPDCONF
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh /bin/sx-httpd.sh && \
    chmod ug+r $HTTPDCONF && \
    rm -f /etc/httpd/conf.d/autoindex.conf && \
    rm -f /etc/httpd/conf.d/welcome.conf && \
    mkdir /data && \
    mkdir $APP_PATH && \
    mkdir /data/logs && \
    mkdir $LOG_PATH && \
    touch $STARTUPLOG
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/run.sh $APP_PATH/sx-httpd.sh && \
    chown -R apache:apache $APP_PATH /data/logs

EXPOSE 80 443
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]