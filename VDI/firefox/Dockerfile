FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="desktop" \
    SX_SERVICE="firefox" \
    SX_ID="startx/vdi-firefox" \
    SX_NAME="Startx Firefox VDI image (fedora rawhide)" \
    SX_SUMMARY="Startx firefox container-based desktop application based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_FIREFOX_SUPERVISOR_CONF=/etc/supervisor/conf.d/ \
    LOG_PATH=/var/log/firefox \
    APP_PATH=/home/firefox \
    SX_FIREFOX_SCREEN_RES_X=1024x768x24 \
    SX_FIREFOX_SCREEN_RES_FIREFOX=1024,768 \
    SX_USER=firefox \
    SX_FIREFOX_PORT=5900

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing firefox browser as container mainstream image with persistence capabilities" \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,firefox,vnc,X11" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="712Mi" \
    io.openshift.min-cpu="600m" \
    io.openshift.expose-VDI="$SX_FIREFOX_PORT:vnc" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,firefox,vnc,X11' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/VDI/firefox/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/vdi-firefox.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/firefox,docker.io/startx/vdi-firefox'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing firefox browser as container mainstream image with persistence capabilities" \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/VDI/firefox/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/VDI/firefox" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY supervisord.conf $SX_FIREFOX_SUPERVISOR_CONF/
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        supervisor \
        python3-pip \
        xorg-x11-server-Xvfb \
        x11vnc \
        firefox \
        python3-setuptools && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    pip install --upgrade pip && \
    # pip install --upgrade --force-reinstall setuptools pip && \
    useradd -s /bin/bash -m -g 0 -u 1001 $SX_USER && \
    mkdir -p /s2i $SX_LIBDIR && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $APP_PATH $LOG_PATH && \
    chgrp -R 0 $APP_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp && \
    chown -R $SX_USER:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $LOG_PATH && \
    chmod -R g=u $APP_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp && \
    chmod ug+r $SX_FIREFOX_SUPERVISOR_CONF && \
    chmod -R ugo+x /bin/sx*

USER $SX_USER

WORKDIR $APP_PATH

EXPOSE $SX_FIREFOX_PORT

ENTRYPOINT ["/bin/entrypoint.sh" ]

CMD [ "/bin/sx-firefox" , "run" ]
