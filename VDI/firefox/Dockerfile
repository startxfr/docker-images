FROM quay.io/startx/alpine:3

ENV SX_VERSION="alpine3" \
    SX_TYPE="desktop" \
    SX_SERVICE="firefox" \
    SX_ID="startx/vdi-firefox" \
    SX_NAME="Startx Firefox VDI image (alpine 3.12)" \
    SX_SUMMARY="Startx firefox container-based desktop application based on alpine 3.12" \
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
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/alpine/VDI/firefox/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/alpine/docs/img/vdi-firefox.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/firefox,docker.io/startx/vdi-firefox' \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing firefox browser as container mainstream image with persistence capabilities" \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/alpine/VDI/firefox/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/alpine/VDI/firefox" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY supervisord.conf $SX_FIREFOX_SUPERVISOR_CONF/
COPY sx /tmp/
RUN apk update && apk upgrade && \
    # echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    # echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache --update --purge -uU -f x11vnc xvfb supervisor inotify-tools python3 py3-pip firefox nss && \
    rm -rf /var/lib/apt/lists/* /var/cache/apk/* /usr/share/man && \
    pip3 install --upgrade --force-reinstall setuptools pip supervisor && \
    useradd -s /bin/bash -m -g 0 -u 1001 $SX_USER && \
    mkdir -p /s2i $SX_LIBDIR /.local && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/* && \
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
