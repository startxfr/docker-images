FROM startx/alpine:3

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (alpine 3.10)" \
    SX_SUMMARY="Startx mariadb service based on alpine 3.10" \
    MY_CONF=/etc/my.cnf \
    DATA_PATH=/data \
    LOG_PATH=/var/log/mariadb \
    LOADSQL_PATH=/tmp/sql \
    DB_CHARSET=utf8 \
    LC_MESSAGES=en_US \
    RUN_BIN=/usr/bin/mysqld

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on mariadb or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,database,mariadb" \
    io.openshift.non-scalable="true" \
    io.openshift.min-memory="256Mi" \
    io.openshift.min-cpu="500m" \
    io.openshift.expose-services="3306:mysql" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
COPY my.cnf $MY_CONF
RUN apk --no-cache add mariadb mariadb-client mysql && \
    mkdir -p $DATA_PATH $LOG_PATH $LOADSQL_PATH /run/mysqld && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql $RUN_BIN /run/mysqld $MY_CONF && \
    chmod -R g=u $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql $RUN_BIN /run/mysqld $MY_CONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod ug+rw $MY_CONF

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]
