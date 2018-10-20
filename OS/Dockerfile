FROM fedora:rawhide

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="OS" \
    SX_SERVICE="fedora" \
    SX_ID="startx/fedora" \
    SX_NAME="Startx OS base image (fedora rawhide)" \
    SX_SUMMARY="Startx OS base image based on fedora rawhide" \
    SX_VERBOSE=true \
    SX_DEBUG=false \
    APP_PATH="/app" \
    SX_S2IDIR="/tmp" \
    SX_LIBDIR="/var/lib/sx"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on bash script or as container mainstream image for your application containers." \
      version="$SX_VERSION" \
      release="3" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="100Mi" \
      io.openshift.min-cpu="500m" \
      io.openshift.s2i.destination="$SX_S2IDIR" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root

COPY sx /tmp/
RUN dnf --nogpgcheck -y install pwgen tar psmisc procps findutils iputils net-tools wget logrotate zip hostname && \
    dnf clean all && \
    mkdir -p $SX_LIBDIR $APP_PATH && \
    chmod -R 775 /tmp/sx/bin /tmp/s2i/bin /tmp/sx/lib && \
    mv /tmp/s2i/bin /s2i && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chgrp -R 0 /bin/sx /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH && \
    chown -R 1001:0 /bin/sx /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH && \
    chmod -R g=u /bin/sx /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH

USER 1001

WORKDIR $APP_PATH

CMD [ "/bin/sx" ]