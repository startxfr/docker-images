FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="chrome" \
    SX_ID="startx/sv-chrome" \
    SX_NAME="Startx Chrome service image (fedora rawhide)" \
    SX_SUMMARY="Startx chrome service based on fedora rawhide" \
    SUPERVISORCONF=/etc/supervisor/conf.d/ \
    LOG_PATH=/home/chrome \
    APP_PATH=/home/chrome \
    DATA_PATH=/home/chrome \
    SCREEN_RES_X=1024x768x24 \
    SCREEN_RES_CHROME=1024,768 \
    SX_USER=chrome

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
      io.openshift.expose-services="5900:vnc" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN dnf --nogpgcheck -y install supervisor xorg-x11-server-Xvfb x11vnc fedora-workstation-repositories dnf-plugins-core pulseaudio python3-setuptools python3-pip && \
    dnf config-manager --set-enabled google-chrome && \
    dnf --nogpgcheck -y install google-chrome-stable chrome-remote-desktop fluxbox && \
    dnf clean all && \
    easy_install pip && \
    pip install --upgrade pip && \
    pip install --upgrade --force-reinstall setuptools pip
COPY copyables/supervisor*.conf $SUPERVISORCONF/
COPY copyables /
COPY sx /tmp/
RUN useradd  -s /bin/bash -m -g 0 -u 1001 -G chrome-remote-desktop,pulse-access chrome && \
    mkdir -p /s2i /var/lib/sx && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH $DATA_PATH/.config/chrome-remote-desktop $DATA_PATH/.fluxbox && \
	ln -s /crdonly /usr/local/sbin/crdonly && \
	ln -s /update /usr/local/sbin/update && \
	echo ' \n\
		session.screen0.toolbar.visible:        false\n\
		session.screen0.fullMaximization:       true\n\
		session.screen0.maxDisableResize:       true\n\
		session.screen0.maxDisableMove: true\n\
		session.screen0.defaultDeco:    NONE\n\
	' >> $DATA_PATH/.fluxbox/init && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp && \
    chown -R $SX_USER:0 /bin/sx* /s2i /var/lib/sx /tmp $APP_PATH $DATA_PATH $LOG_PATH $DATA_PATH/.config $DATA_PATH/.fluxbox && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp && \
    chmod ug+r $SUPERVISORCONF && \
    chmod -R ugo+x /bin/sx*

USER $SX_USER

WORKDIR $DATA_PATH

EXPOSE 5900

VOLUME $DATA_PATH

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD [ "/bin/sx-chrome" ]
