FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="memcache" \
    SX_ID="startx/sv-memcache" \
    SX_NAME="Startx Memcached service image (fedora rawhide)" \
    SX_SUMMARY="Startx Memcached service based on fedora rawhide"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on memcached or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,memcached,database" \
      io.openshift.non-scalable="true" \
      io.openshift.min-memory="600Mi" \
      io.openshift.min-cpu="1500m" \
      io.openshift.expose-services="11211:memcached" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf --nogpgcheck -y install memcached nmap-ncat telnet && dnf clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $LOG_PATH && \
    chgrp -R 0 $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R g=u $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 11211

CMD [ "/bin/sx-memcache" , "run" ]