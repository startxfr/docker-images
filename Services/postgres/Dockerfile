FROM startx/centos:6

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="centos6" \
    SX_TYPE="service" \
    SX_SERVICE="postgres" \
    SX_ID="startx/sv-postgres" \
    SX_NAME="Startx Postgres service image (centos 6)" \
    SX_SUMMARY="Startx postgres service based on centos 6" \
    DATA_PATH=/data \
    LOG_PATH=/logs

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on postgres or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos,database,postgresql" \
      io.openshift.non-scalable="true" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="8000m" \
      io.openshift.expose-services="5432:postgresql" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN yum --nogpgcheck -y install postgresql postgresql-libs postgresql-server \
    && yum clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $LOG_PATH && \
    touch $DATA_PATH/.keep && \
    chown -R postgres:postgres $LOG_PATH $DATA_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH /bin/sx-* /s2i /var/lib/sx* && \
    chown -R 1001:0 /bin/sx-* /s2i /var/lib/sx* && \
    chmod -R g=u $DATA_PATH $LOG_PATH /bin/sx-* /s2i /var/lib/sx* && \
    chmod -R ugo+x /bin/sx*

USER 5432

WORKDIR $DATA_PATH

EXPOSE 5432

VOLUME $DATA_PATH

CMD [ "/bin/sx-postgres" , "run" ]
