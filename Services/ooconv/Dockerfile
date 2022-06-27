FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="ooconv" \
    SX_ID="startx/sv-ooconv" \
    SX_NAME="Startx LibreOffice converter service image (fedora rawhide)" \
    SX_SUMMARY="Startx unoconv service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_USER=ooconv \
    APP_PATH=/home/ooconv \
    LOG_PATH=/var/log/ooconv \
    DATA_PATH=/data

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing OpenOffice document converter or as container mainstream image for your document convertion backend containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,document,libreoffice" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="512Mi" \
    io.openshift.min-cpu="500m" \
    io.openshift.expose-services="2002:unoconv" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,document,libreoffice' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/ooconv/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-ooconv.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/ooconv,docker.io/startx/sv-ooconv'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing OpenOffice document converter or as container mainstream image for your document convertion backend containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/ooconv/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/ooconv" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh
RUN dnf install -yq --nogpgcheck \
        unoconv \
        libreoffice-writer \
        libreoffice-calc \
        libreoffice-postgresql \
        pdfmod \
        ghostscript
RUN package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    useradd -s /bin/bash -m -g 0 -u 1001 ooconv && \
    mkdir -p $DATA_PATH /.cache && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chgrp -R 0 $DATA_PATH /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chmod -R g=u $DATA_PATH /bin/sx-* /s2i $SX_LIBDIR* /.cache && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+wx /.cache

USER 1001

WORKDIR $DATA_PATH

EXPOSE 2002

VOLUME $DATA_PATH

CMD [ "/bin/sx-ooconv" , "run" ]
