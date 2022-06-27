FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="desktop" \
    SX_SERVICE="chrome" \
    SX_ID="startx/vdi-chrome" \
    SX_NAME="Startx Chrome VDI image (fedora rawhide)" \
    SX_SUMMARY="Startx chrome container-based desktop application based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_CHROME_SUPERVISOR_CONF=/etc/supervisor/conf.d/ \
    LOG_PATH=/var/log/chrome \
    APP_PATH=/home/chrome \
    DATA_PATH=/home/chrome \
    SX_CHROME_SCREEN_RES_X=1024x768x24 \
    SX_CHROME_SCREEN_RES_CHROME=1024,768 \
    SX_USER=chrome \
    SX_CHROME_PORT=5900

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing chrome browser as container mainstream image with persistence capabilities" \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,chrome,vnc,X11" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="712Mi" \
    io.openshift.min-cpu="1000m" \
    io.openshift.expose-VDI="$SX_CHROME_PORT:vnc" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,chrome,vnc,X11' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/VDI/chrome/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/vdi-chrome.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/chrome,docker.io/startx/vdi-chrome'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing chrome browser as container mainstream image with persistence capabilities" \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/VDI/chrome/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/VDI/chrome" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY supervisord.conf $SX_CHROME_SUPERVISOR_CONF/
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        supervisor \
        python3-pip \
        xorg-x11-server-Xvfb \
        x11vnc \
        fedora-workstation-repositories \
        dnf-plugins-core \
        pulseaudio \
        python3-setuptools && \
    dnf config-manager --set-enabled google-chrome && \
    dnf install -yq --nogpgcheck google-chrome-stable && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    pip install --upgrade pip && \
    # pip install --upgrade --force-reinstall setuptools pip && \
    useradd -s /bin/bash -m -g 0 -u 1001 -G pulse-access $SX_USER && \
    mkdir -p /s2i $SX_LIBDIR /.local && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH $DATA_PATH/.config && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp /.local && \
    chown -R $SX_USER:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $DATA_PATH $LOG_PATH $DATA_PATH/.config /.local && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp /.local && \
    chmod ug+r $SX_CHROME_SUPERVISOR_CONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx /.local

USER $SX_USER

WORKDIR $DATA_PATH

EXPOSE $SX_CHROME_PORT

VOLUME $DATA_PATH

ENTRYPOINT ["/bin/entrypoint.sh" ]

CMD [ "/bin/sx-chrome" , "run" ]
