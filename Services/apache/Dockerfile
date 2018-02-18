FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="apache" \
    SX_ID="startx/sv-apache" \
    SX_NAME="Startx Apache service image (fedora rawhide)" \
    SX_SUMMARY="Startx apache service based on fedora rawhide" \
    HTTPDCONF=/etc/httpd/conf.d/app.conf \
    LOG_PATH=/var/log/httpd \
    APP_PATH=/app \
    DATA_PATH=/data

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on http or as container mainstream image for your web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,apache,httpd" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="200Mi" \
      io.openshift.min-cpu="1000m" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY lib/* /bin/
COPY .s2i/bin/* /s2i/
RUN dnf -y install httpd && dnf clean all && \
    chmod -R 775 /bin/sx* /s2i && \
    mv /bin/sx.sh /bin/sx-apache && \
    cat /etc/httpd/conf/httpd.conf | sed -e "s/Listen 80/#Listen 80/" > /etc/httpd/conf/httpd.conf && \
    chmod ug+r $HTTPDCONF && \
    rm -f /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /run/httpd /bin/sx*.sh /bin/sx-apache && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /run/httpd /bin/sx*.sh /bin/sx-apache && \
    chmod -R ugo+rwx $LOG_PATH
COPY ./ $APP_PATH
RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/lib && \
    chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $APP_PATH
VOLUME $LOG_PATH
VOLUME $DATA_PATH

ONBUILD COPY ./ $APP_PATH
ONBUILD RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/lib && chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH

CMD [ "/bin/sx-apache" , "start" ]
