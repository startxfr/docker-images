FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="mongo" \
    SX_ID="startx/sv-mongo" \
    SX_NAME="Startx MongoDB service image (fedora rawhide)" \
    SX_SUMMARY="Startx mongo service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    LOG_PATH=/var/log/mongodb \
    MONGO_RUNTIME=/usr/bin/mongod \
    MONGO_USER=mongod \
    DATA_PATH=/data

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on mongo or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,database,mongo" \
    io.openshift.non-scalable="true" \
    io.openshift.min-memory="512Mi" \
    io.openshift.min-cpu="1000m" \
    io.openshift.expose-services="27017:mongodb" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,database,mongo' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/mongo/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-mongo.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/mongo,docker.io/startx/sv-mongo'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing database based on mongo or as container mainstream image for your database backend containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/mongo/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/mongo" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
COPY mongodb-org.repo /etc/yum.repos.d/mongodb-org.repo
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        mongodb-database-tools \
        mongodb-org \
        mongodb-org-database-tools-extra \
        mongodb-org-mongos \
        mongodb-org-server \
        mongodb-org-shell \
        mongodb-org-tools && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
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

EXPOSE 27017 28017

VOLUME $DATA_PATH

CMD [ "/bin/sx-mongo" , "run" ]
