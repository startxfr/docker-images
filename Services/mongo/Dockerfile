FROM startx/ubi:8

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="ubi8" \
    SX_TYPE="service" \
    SX_SERVICE="mongo" \
    SX_ID="startx/sv-mongo" \
    SX_NAME="Startx MongoDB service image (UBI 8)" \
    SX_SUMMARY="Startx mongo service based on RedHat UBI 8" \
    LOG_PATH=/var/log/mongodb \
    MONGO_RUNTIME=/usr/bin/mongod \
    MONGO_USER=mongo \
    DATA_PATH=/data

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on mongo or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="$SX_VERSION" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos,database,mongo" \
      io.openshift.non-scalable="true" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="8000m" \
      io.openshift.expose-services="27017:mongodb" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
COPY mongodb-org.repo /etc/yum.repos.d/mongodb-org.repo
RUN dnf install -y yum-utils && dnf upgrade -y --refresh && \
    dnf install -y --nogpgcheck mongodb-org-unstable && \
    dnf remove -y --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    usermod -a -G 0 $MONGO_USER && \
    mkdir -p $DATA_PATH && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $LOG_PATH && \
    chown -R $MONGO_USER:$MONGO_USER $DATA_PATH $LOG_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R g=u $DATA_PATH $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $DATA_PATH

EXPOSE 27017

VOLUME $DATA_PATH

CMD [ "/bin/sx-mongo" , "run" ]