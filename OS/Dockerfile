FROM centos:7

ENV SX_VERSION="centos7" \
    SX_TYPE="OS" \
    SX_SERVICE="centos" \
    SX_ID="startx/centos" \
    SX_NAME="Startx OS base image (Centos 7)" \
    SX_SUMMARY="Startx OS base image based on Centos 7" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
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
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing application based on bash script or as container mainstream image for your application containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    org.opencontainers.image.version="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    org.opencontainers.image.vendor="STARTX" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.k8s.description="$SX_SUMMARY" \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2025-03-04T00:00:00Z' \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,centos" \
    io.artifacthub.package.keywords='startx,os,centos' \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="32Mi" \
    io.openshift.min-cpu="50m" \
    io.openshift.s2i.destination="$SX_S2IDIR" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/centos7/OS/centos/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/centos7/OS" \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/centos7/OS/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/centos7/docs/img/os-centos.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/centos:7,docker.io/startx/centos:7'

USER root
COPY sx /tmp/
RUN echo "keepcache=0" >>/etc/yum.conf && \
    yum install -y -q yum-utils epel-release && \
    yum-config-manager --enable cr epel-release extras centosplus && \
    yum upgrade -y -q && \
    yum install -y -q \
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
    logrotate \
    bash-completion \
    vim \
    glibc-langpack-fr && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\* && \
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
