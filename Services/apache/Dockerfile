FROM startx/centos:6

ENV SX_VERSION="centos6" \
    SX_TYPE="service" \
    SX_SERVICE="apache" \
    SX_ID="startx/sv-apache" \
    SX_NAME="Startx Apache service image (centos 6)" \
    SX_SUMMARY="Startx apache service based on centos 6" \
    HTTPDCONF=/etc/httpd/conf/httpd.conf \
    LOG_PATH=/var/log/httpd \
    APP_PATH=/app \
    RUN_CONF_DIR=/etc/httpd/conf.d \
    RUN_CONF=/etc/httpd/conf/httpd.conf \
    RUN_DIR=/var/run/httpd \
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
    io.openshift.tags="startx,os,centos,apache,httpd" \
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
COPY sx /tmp/
RUN yum install -y -q  yum-utils && \
    yum upgrade -y -q  && \
    yum install -y -q  --nogpgcheck \
    httpd && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    [ -w $RUN_CONF ] && sed -i "s/Listen 80/#Listen 80/" $RUN_CONF && \
    rm -f $RUN_CONF_DIR/autoindex.conf $RUN_CONF_DIR/userdir.conf $RUN_CONF_DIR/welcome.conf $RUN_DIR/httpd.pid && \
    mkdir -p $APP_PATH $LOG_PATH && \
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
