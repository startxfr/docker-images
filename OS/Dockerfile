FROM fedora:26

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="26" \
    SX_TYPE="OS" \
    SX_SERVICE="fedora" \
    SX_ID="startx/fedora" \
    SX_NAME="Startx OS base image (fedora rawhide)" \
    SX_SUMMARY="Startx OS base image based on fedora rawhide"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on bash script or as container mainstream image for your application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora" \
      io.openshift.non-scalable="true" \
      io.openshift.min-memory="100Mi" \
      io.openshift.min-cpu="500m" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY lib/sx* /bin/
COPY .s2i/bin/* /s2i/
# Install minimal packages
RUN dnf -y install pwgen tar psmisc procps findutils iputils net-tools wget logrotate zip hostname && \
    dnf clean all && \
    chmod -R 775 /bin/sx-lib.sh /bin/sx.sh /s2i && \
    mv /bin/sx.sh /bin/sx && \
    chgrp -R 0 /bin/sx*.sh /bin/sx /tmp && \
    chown -R 1001:0 /tmp && \
    chmod -R g=u /bin/sx*.sh /bin/sx /tmp

USER 1001

WORKDIR /tmp

CMD [ "/bin/sx" ]
