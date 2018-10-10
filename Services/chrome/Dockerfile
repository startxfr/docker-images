FROM siomiz/chrome

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="chrome" \
    SX_ID="startx/sv-chrome" \
    SX_NAME="Startx Chrome service image (fedora rawhide)" \
    SX_SUMMARY="Startx chrome service based on fedora rawhide" \
    SUPERVISORCONF=/etc/supervisor/conf.d/supervisord.conf \
    LOG_PATH=/home/chrome \
    APP_PATH=/home/chrome \
    DATA_PATH=/home/chrome \
    SCREEN_RES=1024x768x24 \
    SCREEN_RES1=1024,768

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing chrome browser as container mainstream image for your web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,chrome,vnc,X11" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="400Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-services="5900:vnc" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

#USER root
COPY supervisord.conf $SUPERVISORCONF
COPY sx /tmp/
RUN mkdir -p /s2i /var/lib/sx && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp && \
    chown -R 1001:0 /bin/sx* /s2i /var/lib/sx /tmp $APP_PATH $DATA_PATH $LOG_PATH && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp && \
    chmod ug+r $SUPERVISORCONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH && \
    chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH

#USER 1001

WORKDIR $DATA_PATH

EXPOSE 5900

VOLUME $DATA_PATH

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", $SUPERVISORCONF]
