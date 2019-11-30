FROM startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (fedora rawhide)" \
    SX_SUMMARY="Startx mariadb service based on fedora rawhide" \
    MY_CONF=/etc/my.cnf \
    DATA_PATH=/data \
    LOG_PATH=/var/log/mariadb \
    LOADSQL_PATH=/tmp/sql  \
    DB_CHARSET=utf8 \
    LC_MESSAGES=en_US \
    RUN_BIN="mysqld_safe"

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
    io.openshift.min-memory="400Mi" \
    io.openshift.min-cpu="3000m" \
    io.openshift.expose-services="3306:mysql" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
COPY my.cnf $MY_CONF
RUN dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    mariadb-tokudb-engine \
    mariadb-connect-engine \
    mariadb-rocksdb-engine \
    mariadb-oqgraph-engine \
    mariadb-connector-c \
    mariadb-connector-odbc \
    mariadb-server-utils \
    mariadb-java-client \
    mariadb-backup \
    mariadb-common \
    mariadb-errmsg \
    mariadb-gssapi-server \
    mariadb-cracklib-password-check \
    glibc-langpack-fr \
    mariadb && \
    package-cleanup --problems && \
    package-cleanup --cleandupes; \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mkdir -p $DATA_PATH $LOG_PATH $LOADSQL_PATH && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql /var/run/mariadb $MY_CONF && \
    chmod -R g=u $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql /var/run/mariadb $MY_CONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod ug+rw $MY_CONF

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]
