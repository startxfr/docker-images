FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="desktop" \
    SX_SERVICE="firefox" \
    SX_ID="startx/vdi-firefox" \
    SX_NAME="Startx Firefox VDI image (fedora rawhide)" \
    SX_SUMMARY="Startx firefox container-based desktop application based on fedora rawhide" \
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
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,firefox,vnc,X11" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="712Mi" \
    io.openshift.min-cpu="600m" \
    io.openshift.expose-VDI="$SX_FIREFOX_PORT:vnc" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY supervisord.conf $SX_FIREFOX_SUPERVISOR_CONF/
COPY sx /tmp/
RUN wget -q https://rpmfind.net/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/p/python-meld3-2.0.0-2.fc32.noarch.rpm && \
    rpm -ivh python-meld3-2.0.0-2.fc32.noarch.rpm && \
    dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    supervisor \
    xorg-x11-server-Xvfb \
    x11vnc \
    firefox \
    python2-setuptools && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    easy_install pip && \
    pip install --upgrade pip && \
    pip install --upgrade --force-reinstall setuptools pip && \
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
