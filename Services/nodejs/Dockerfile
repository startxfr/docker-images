FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="nodejs" \
    SX_ID="startx/sv-nodejs" \
    SX_NAME="Startx Nodejs service image (fedora rawhide)" \
    SX_SUMMARY="Startx nodejs service based on fedora rawhide" \
    LOG_PATH=/var/log/nodejs \
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
COPY sx /tmp/
RUN dnf --nogpgcheck -y install nodejs npm python make gcc git && dnf clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH /.npm /.config  && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /.config /.npm && \
    chown -R 1001:0 /bin/sx* /s2i && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /.config /.npm && \
    chmod -R ugo+rwx $LOG_PATH /.config /.npm && \
    chmod -R ugo+x /bin/sx*
COPY ./ $APP_PATH
RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/openshift-* $APP_PATH/docker-* $APP_PATH/sx && \
    chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "run" ]