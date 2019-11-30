FROM fedora:rawhide

ENV SX_VERSION="fc32" \
    SX_TYPE="OS" \
    SX_SERVICE="fedora" \
    SX_ID="startx/fedora" \
    SX_NAME="Startx OS base image (fedora 32)" \
    SX_SUMMARY="Startx OS base image based on fedora 32" \
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
    release="$SX_VERSION" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="500m" \
    io.openshift.s2i.destination="$SX_S2IDIR" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root

COPY sx /tmp/

RUN echo "keepcache=0" >> /etc/dnf/dnf.conf && \
    dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq \
    pwgen \
    tar \
    unzip \
    zip \
    hostname \
    psmisc \
    procps \
    findutils \
    iputils \
    net-tools \
    wget \
    curl \
    logrotate \
    bash-completion \
    glibc-langpack-fr \
    vim && \
    package-cleanup --problems && \
    package-cleanup --cleandupes; \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\* && \
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