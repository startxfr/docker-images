FROM centos:7

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="7" \
    SX_TYPE="OS" \
    SX_SERVICE="centos" \
    SX_ID="startx/centos" \
    SX_NAME="Startx OS base image (centos 7)" \
    SX_SUMMARY="Startx OS base image based on centos 7" \
    SX_VERBOSE=true \
    SX_DEBUG=false \
    APP_PATH="/app" \
    LOG_PATH=/var/log/sx \
    SX_S2IDIR="/tmp" \
    SX_LIBDIR="/var/lib/sx" \
    DAEMON_STOP_TIMEOUT=3 \
    DAEMON_START_INTERVAL=10

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on bash script or as container mainstream image for your application containers." \
      version="$SX_VERSION" \
      release="3" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="128Mi" \
      io.openshift.min-cpu="500m" \
      io.openshift.s2i.destination="$SX_S2IDIR" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root

COPY sx /tmp/
RUN yum --nogpgcheck -y install pwgen tar psmisc procps findutils iputils net-tools wget logrotate zip hostname epel-release  bash-completion vim glibc-langpack-fr && \
    yum clean all && \
    mkdir -p $SX_LIBDIR $APP_PATH $LOG_PATH && \
    chmod -R 775 /tmp/sx/bin /tmp/s2i/bin /tmp/sx/lib && \
    mv /tmp/s2i/bin /s2i && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chgrp -R 0 /bin/sx /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR $APP_PATH $LOG_PATH && \
    chown -R 1001:0 /bin/sx /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR $APP_PATH $LOG_PATH && \
    chmod -R g=u /bin/sx /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR $APP_PATH $LOG_PATH && \
    chmod -R ugo+wr $SX_S2IDIR $APP_PATH $LOG_PATH

USER 1001

WORKDIR $APP_PATH

CMD [ "/bin/sx", "daemon" ]
