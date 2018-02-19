FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="nodejs" \
    SX_ID="startx/sv-nodejs" \
    SX_NAME="Startx Nodejs service image (fedora rawhide)" \
    SX_SUMMARY="Startx nodejs service based on fedora rawhide" \
    HTTPDCONF=/etc/httpd/conf.d/app.conf \
    LOG_PATH=/var/log/httpd \
    APP_PATH=/app \
    DATA_PATH=/data \
    APP_MAIN=/app/app.js

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on nodejs or as container mainstream image for your micro-service containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,nodejs,httpd" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="200Mi" \
      io.openshift.min-cpu="1000m" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY lib/* /bin/
COPY .s2i/bin/* /s2i/
RUN dnf -y install nodejs npm python make gcc && dnf clean all && \
    chmod -R 775 /bin/sx* /s2i && \
    mv /bin/sx.sh /bin/sx-nodejs && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH && \
    touch /.config /.npm && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx*.sh /bin/sx-nodejs /.config /.npm && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx*.sh /bin/sx-nodejs /.config /.npm && \
    chmod -R ugo+rwx $LOG_PATH
COPY ./ $APP_PATH
RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/openshift-* $APP_PATH/docker-* $APP_PATH/.s2i $APP_PATH/lib && \
    chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "start" ]