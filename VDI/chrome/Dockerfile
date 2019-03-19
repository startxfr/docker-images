FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="desktop" \
    SX_SERVICE="chrome" \
    SX_ID="startx/vdi-chrome" \
    SX_NAME="Startx Chrome VDI image (fedora rawhide)" \
    SX_SUMMARY="Startx chrome container-based desktop application based on fedora rawhide" \
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
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,chrome,vnc,X11" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="400Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-VDI="$SX_CHROME_PORT:vnc" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY supervisord.conf $SX_CHROME_SUPERVISOR_CONF/
COPY sx /tmp/
RUN wget https://rpmfind.net/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/p/python-meld3-1.0.2-10.fc30.noarch.rpm && \
    rpm -ivh python-meld3-1.0.2-10.fc30.noarch.rpm --nodeps && \
    dnf --nogpgcheck -y install supervisor xorg-x11-server-Xvfb x11vnc fedora-workstation-repositories dnf-plugins-core pulseaudio python2-meld3  python2-setuptools && \
    dnf config-manager --set-enabled google-chrome && \
    dnf --nogpgcheck -y install google-chrome-stable && \
    dnf clean all && \
    easy_install pip && \
    pip install --upgrade pip && \
    pip install --upgrade --force-reinstall setuptools pip && \
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
