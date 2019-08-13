FROM startx/centos:6

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="centos6" \
    SX_TYPE="service" \
    SX_SERVICE="mongo" \
    SX_ID="startx/sv-mongo" \
    SX_NAME="Startx MongoDB service image (centos 6)" \
    SX_SUMMARY="Startx mongo service based on centos 6" \
    LOG_PATH=/var/log/mongodb \
    MONGO_RUNTIME=/usr/bin/mongod \ 
    MONGO_USER=mongodb \
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
RUN yum install -yq yum-utils && \
    yum upgrade -yq && \
    yum install -yq --nogpgcheck --enablerepo=epel \
        mongodb-server && \
    package-cleanup --problems && \
    package-cleanup --cleandupes; \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\* && \
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