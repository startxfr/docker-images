FROM startx/fedora:26

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="fc26" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (fedora 26)" \
    SX_SUMMARY="Startx mariadb service based on fedora 26" \
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
      io.openshift.tags="startx,os,fedora,database,mariadb" \
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
RUN dnf --nogpgcheck -y install mariadb-tokudb-engine mariadb-connect-engine mariadb-rocksdb-engine mariadb-oqgraph-engine mariadb-connector-c mariadb-connector-odbc mariadb-server-utils mariadb-java-client mariadb-backup mariadb-common mariadb-config mariadb-errmsg mariadb-gssapi-server mariadb-cracklib-password-check mariadb && \
    dnf clean all && \
    mkdir -p $DATA_PATH $LOG_PATH $LOADSQL_PATH && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i /var/lib/sx* /var/lib/mysql /var/run/mariadb && \
    chown -R 1001:0 /bin/sx-* /s2i $LOADSQL_PATH /var/lib/sx* && \
    chmod -R g=u $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i /var/lib/sx* /var/lib/mysql /var/run/mariadb && \
    chmod -R ugo+x /bin/sx* && \
    chmod ug+r $MY_CONF

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]