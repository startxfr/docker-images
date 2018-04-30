FROM startx/alpine:3

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (alpine 3.7)" \
    SX_SUMMARY="Startx mariadb service based on alpine 3.7" \
    MY_CONF=/etc/my.cnf \
    DATA_PATH=/data \
    LOG_PATH=/logs \
    LOADSQL_PATH=/tmp/sql 

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on mariadb or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,alpine,database,mariadb" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="400Mi" \
      io.openshift.min-cpu="3000m" \
      io.openshift.expose-services="3306:mysql" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY my.cnf $MY_CONF
COPY sx /tmp/
RUN apk --no-cache add mariadb mariadb-client mysql && \
    mkdir -p $DATA_PATH $LOG_PATH $LOADSQL_PATH && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i /var/lib/sx* /var/lib/mysql /usr/bin/mysqld /run/mysqld && \
    chown -R 1001:0 /bin/sx-* /s2i $LOADSQL_PATH /var/lib/sx* && \
    chmod -R g=u $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i /var/lib/sx* /var/lib/mysql /usr/bin/mysqld /run/mysqld && \
    chmod -R ugo+x /bin/sx* && \
    chmod ug+r $MY_CONF

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]