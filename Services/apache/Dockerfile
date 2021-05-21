FROM quay.io/startx/alpine:3

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="apache" \
    SX_ID="startx/sv-apache" \
    SX_NAME="Startx Apache service image (alpine 3.12)" \
    SX_SUMMARY="Startx apache service based on alpine 3.12" \
    HTTPDCONF=/etc/apache2/conf.d/app.conf \
    LOG_PATH=/var/log/apache2 \
    APP_PATH=/app \
    RUN_CONF_DIR=/etc/apache2/conf.d \
    RUN_CONF=/etc/apache2/httpd.conf \
    RUN_DIR=/run/apache2 \
    RUN_BIN=/usr/sbin/httpd \
    APP_PORT=8080

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing application based on http or as container mainstream image for your web application containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,alpine,apache,httpd" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    io.openshift.expose-services="$APP_PORT:http" \
    io.openshift.s2i.destination="$SX_S2IDIR" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY sx /tmp/sx
RUN apk --no-cache add apache2 curl ca-certificates openssl tzdata openntpd && \
    mv /tmp/sx/s2i/bin/* /s2i/ && \
    mv /tmp/sx/sx/bin/* /bin/ && \
    mv /tmp/sx/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx && \
    sed -i "s/Listen 80/#Listen 80/" $RUN_CONF && \
    rm -f $RUN_CONF_DIR/autoindex.conf $RUN_CONF_DIR/userdir.conf $RUN_CONF_DIR/welcome.conf $RUN_DIR/httpd.pid && \
    mkdir -p $APP_PATH $LOG_PATH $RUN_DIR && \
    chgrp -R 0 $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR $APP_PATH $LOG_PATH && \
    chmod -R g=u $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR && \
    chmod ug+r $HTTPDCONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH
COPY index.html $APP_PATH/index.html
RUN chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $LOG_PATH

CMD [ "/bin/sx-apache" , "run" ]
