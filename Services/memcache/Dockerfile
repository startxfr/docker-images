FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="memcache" \
    SX_ID="startx/sv-memcache" \
    SX_NAME="Startx Memcached service image (fedora rawhide)" \
    SX_SUMMARY="Startx Memcached service based on fedora rawhide" \
    LOG_PATH=/var/log/httpd

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on memcached or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,memcached,database" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="200Mi" \
      io.openshift.min-cpu="1000m" \
      io.openshift.expose-services="11211:memcached" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY lib/* /bin/
COPY .s2i/bin/* /s2i/
RUN dnf -y install memcached && dnf clean all && \
    chmod -R 775 /bin/sx* /s2i && \
    mv /bin/sx.sh /bin/sx-memcache && \
    mkdir -p $LOG_PATH && \
    chgrp -R 0 $LOG_PATH /bin/sx*.sh /bin/sx-memcache && \
    chmod -R g=u $LOG_PATH /bin/sx*.sh /bin/sx-memcache && \
    chmod -R ugo+rwx $LOG_PATH

USER 1001

WORKDIR /tmp

EXPOSE 11211

VOLUME $LOG_PATH

CMD [ "/bin/sx-memcache" , "start" ]