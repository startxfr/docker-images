FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="nodejs" \
    SX_ID="startx/sv-nodejs" \
    SX_NAME="Startx Nodejs service image (fedora rawhide)" \
    SX_SUMMARY="Startx nodejs service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    LOG_PATH=/var/log/nodejs \
    APP_PATH=/app \
    DATA_PATH=/data \
    APP_MAIN=/app/app.js

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing application based on nodejs or as container mainstream image for your micro-service containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,nodejs,httpd" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="64Mi" \
    io.openshift.min-cpu="100m" \
    io.openshift.expose-services="8080:http" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \ 
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,nodejs,httpd' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/nodejs/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-nodejs.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/nodejs,docker.io/startx/sv-nodejs'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing application based on nodejs or as container mainstream image for your micro-service containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/nodejs/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/nodejs" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
COPY *.j* $APP_PATH/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        nodejs \
        npm \
        python \
        make \
        gcc \
        gcc-c++ \
        git && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    mkdir -p $DATA_PATH $APP_PATH $LOG_PATH /.npm /.config && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /.config /.npm && \
    chown -R 1001:0 /bin/sx* /s2i && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /.config /.npm && \
    chmod -R ugo+rwx $LOG_PATH /.config /.npm && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "run" ]
