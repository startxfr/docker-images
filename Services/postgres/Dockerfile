FROM startx/ubi:8

ENV SX_VERSION="ubi8" \
    SX_TYPE="service" \
    SX_SERVICE="postgres" \
    SX_ID="startx/sv-postgres" \
    SX_NAME="Startx Postgres service image (UBI 8)" \
    SX_SUMMARY="Startx postgres service based on RedHat UBI 8" \
    DATA_PATH=/data \
    LOG_PATH=/var/log/postgres \
    RPM_REPO=https://yum.postgresql.org/testing/12/redhat/rhel-8-x86_64

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on postgres or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,database,postgresql" \
    io.openshift.non-scalable="true" \
    io.openshift.min-memory="1Gi" \
    io.openshift.min-cpu="8000m" \
    io.openshift.expose-services="5432:postgresql" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/ 
RUN dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    libicu \
    libpq && \
    rpm -ivh $RPM_REPO/postgresql12-libs-12.1-1PGDG.rhel8.x86_64.rpm && \
    rpm -ivh $RPM_REPO/postgresql12-12.1-1PGDG.rhel8.x86_64.rpm && \
    rpm -ivh $RPM_REPO/postgresql12-server-12.1-1PGDG.rhel8.x86_64.rpm && \
    package-cleanup --problems && \
    package-cleanup --cleandupes; \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $LOG_PATH && \
    touch $DATA_PATH/.keep && \
    chmod -R ug+rwx $LOG_PATH $DATA_PATH && \
    chgrp -R 0 $DATA_PATH $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R g=u $DATA_PATH $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $DATA_PATH

EXPOSE 5432

VOLUME $DATA_PATH

CMD [ "/bin/sx-postgres" , "run" ]
