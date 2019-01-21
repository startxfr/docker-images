FROM startx/alpine:3

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="ooconv" \
    SX_ID="startx/sv-ooconv" \
    SX_NAME="Startx LibreOffice converter service image (alpine 3.8)" \
    SX_SUMMARY="Startx unoconv service based on alpine 3.8" \
    SX_USER=ooconv \
    APP_PATH=/home/ooconv \
    DATA_PATH=/data

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing OpenOffice document converter or as container mainstream image for your document convertion backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,alpine,document,libreoffice" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="1500Mi" \
      io.openshift.min-cpu="8000m" \
      io.openshift.expose-services="2002:unoconv" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN apk --no-cache add mc curl util-linux libreoffice-common libreoffice-writer \
    ttf-droid-nonlatin ttf-droid ttf-dejavu ttf-freefont ttf-liberation \
    && curl -Ls https://raw.githubusercontent.com/dagwieers/unoconv/master/unoconv -o /usr/local/bin/unoconv \
    && chmod +x /usr/local/bin/unoconv \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apk del curl \
    && rm -rf /var/cache/apk/* && \
    useradd -s /bin/bash -m -g 0 -u 1001 ooconv && \
    mkdir -p $DATA_PATH /.cache && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chgrp -R 0 $DATA_PATH /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chmod -R g=u $DATA_PATH /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+wx /.cache

USER 1001

WORKDIR $DATA_PATH

EXPOSE 2002

VOLUME $APP_PATH
VOLUME $DATA_PATH

CMD [ "/bin/sx-ooconv" , "run" ]