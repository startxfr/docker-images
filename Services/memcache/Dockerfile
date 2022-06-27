FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="memcache" \
    SX_ID="startx/sv-memcache" \
    SX_NAME="Startx Memcached service image (fedora rawhide)" \
    SX_SUMMARY="Startx Memcached service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on memcached or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,memcached,database" \
    io.openshift.non-scalable="true" \
    io.openshift.min-memory="512Mi" \
    io.openshift.min-cpu="500m" \
    io.openshift.expose-services="11211:memcached" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,memcached,database' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/memcache/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-memcache.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/memcache,docker.io/startx/sv-memcache'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing database based on memcached or as container mainstream image for your database backend containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/memcache/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/memcache" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        memcached \
        nmap-ncat \
        telnet && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $LOG_PATH && \
    chgrp -R 0 $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R g=u $LOG_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 11211

CMD [ "/bin/sx-memcache" , "run" ]
