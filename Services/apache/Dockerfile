FROM startx/alpine:3.7

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="apache" \
    SX_ID="startx/sv-apache" \
    SX_NAME="Startx Apache service image (alpine 3.7)" \
    SX_SUMMARY="Startx apache service based on alpine 3.7" \
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
      io.openshift.tags="startx,os,alpine,apache,httpd" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="200Mi" \
      io.openshift.min-cpu="1000m" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY sx /tmp/
RUN dnf --nogpgcheck -y install httpd && dnf clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    cat /etc/httpd/conf/httpd.conf | sed -e "s/Listen 80/#Listen 80/" > /etc/httpd/conf/httpd.conf && \
    rm -f /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /run/httpd /bin/sx* /s2i /var/lib/sx /tmp && \
    chown -R 1001:0 /bin/sx* /s2i /var/lib/sx /tmp && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /run/httpd /bin/sx* /s2i /var/lib/sx /tmp && \
    chmod ug+r $HTTPDCONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH
COPY index.html $APP_PATH/index.html
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-apache" , "run" ]
