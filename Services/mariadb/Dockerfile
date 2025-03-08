FROM quay.io/startx/centos:7

ENV SX_VERSION="centos7" \
    SX_TYPE="service" \
    SX_SERVICE="mariadb" \
    SX_ID="startx/sv-mariadb" \
    SX_NAME="Startx Mariadb service image (Centos 7)" \
    SX_SUMMARY="Startx mariadb service based on Centos 7" \
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
    io.openshift.tags="startx,os,centos,database,mariadb" \
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
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/centos7/Services/mariadb/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/centos7/docs/img/sv-mariadb.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/mariadb,docker.io/startx/sv-mariadb'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2025-03-04T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing database based on mariadb or as container mainstream image for your database backend containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/centos7/Services/mariadb/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/centos7/Services/mariadb" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
COPY my.cnf $MY_CONF
COPY mariadb.repo /etc/yum.repos.d/mariadb.repo
RUN yum install -y -q yum-utils && \
    yum upgrade -y -q && \
    yum install -y -q --nogpgcheck \
    mariadb-libs \
    mariadb-server \
    mariadb && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\* && \
    mkdir -p $DATA_PATH $LOG_PATH $LOADSQL_PATH && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql $MY_CONF && \
    chmod -R g=u $DATA_PATH $LOG_PATH $LOADSQL_PATH /bin/sx-* /s2i $SX_LIBDIR* /var/lib/mysql $MY_CONF && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $LOADSQL_PATH

EXPOSE 3306

VOLUME $DATA_PATH

CMD [ "/bin/sx-mariadb" , "run" ]
