FROM startx/centos:7

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="ooconv" \
    SX_ID="startx/sv-ooconv" \
    SX_NAME="Startx LibreOffice converter service image (centos 7)" \
    SX_SUMMARY="Startx unoconv service based on centos 7" \
    DATA_PATH=/data

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing OpenOffice document converter or as container mainstream image for your document convertion backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos,document,libreoffice" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="1500Mi" \
      io.openshift.min-cpu="8000m" \
      io.openshift.expose-services="2002:unoconv" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf -y install unoconv libreoffice-writer libreoffice-calc pdfmod ghostscript && \
    dnf clean all && \
    mkdir -p $DATA_PATH /.cache && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chgrp -R 0 $DATA_PATH /bin/sx-* /s2i /var/lib/sx* /.cache && \
    chown -R 1001:0 /bin/sx-* /s2i /var/lib/sx* /.cache && \
    chmod -R g=u $DATA_PATH /bin/sx-* /s2i /var/lib/sx* /.cache && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $DATA_PATH

EXPOSE 2002

VOLUME $DATA_PATH

CMD [ "/bin/sx-ooconv" , "start" ]
