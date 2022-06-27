FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (fedora rawhide)" \
    SX_SUMMARY="Startx mariadb service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    MY_CONF=/etc/my.cnf \
    DATA_PATH=/data \
    LOG_PATH=/var/log/mariadb \
    LOADSQL_PATH=/tmp/sql \
    DB_CHARSET=utf8 \
    LC_MESSAGES=en_US \
    RUN_BIN="mysqld_safe"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on mariadb or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
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
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,database,mariadb' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/mariadb/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-mariadb.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/mariadb,docker.io/startx/sv-mariadb'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing database based on mariadb or as container mainstream image for your database backend containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/mariadb/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/mariadb" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
COPY my.cnf $MY_CONF
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        mariadb-connect-engine \
        mariadb-connector-odbc \
        mariadb-embedded \
        mariadb-pam \
        mariadb-rocksdb-engine \
        mariadb-s3-engine \
        mariadb-server \
        mariadb-server-utils \
        mariadb-sphinx-engine \
        mariadb-backup \
        mariadb-common \
        mariadb-cracklib-password-check \
        mariadb-errmsg \
        mariadb-gssapi-server \
        mariadb-server-galera \
        mysql-selinux \
        python3-mysqlclient \
        glibc-langpack-fr \
        mariadb && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
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
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]
