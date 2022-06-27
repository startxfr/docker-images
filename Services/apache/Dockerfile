FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="apache" \
    SX_ID="startx/sv-apache" \
    SX_NAME="Startx Apache service image (fedora rawhide)" \
    SX_SUMMARY="Startx apache service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    HTTPDCONF=/etc/httpd/conf.d/app.conf \
    LOG_PATH=/var/log/httpd \
    APP_PATH=/app \
    RUN_CONF_DIR=/etc/httpd/conf.d \
    RUN_CONF=/etc/httpd/conf/httpd.conf \
    RUN_DIR=/run/httpd \
    RUN_BIN=/usr/sbin/httpd \
    APP_PORT=8080

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing application based on http or as container mainstream image for your web application containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,apache,httpd" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    io.openshift.expose-services="$APP_PORT:http" \
    io.openshift.s2i.destination="$SX_S2IDIR" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,apache,httpd' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/apache/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-apache.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/apache,docker.io/startx/sv-apache' \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing application based on http or as container mainstream image for your web application containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/apache/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/apache" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY httpd.conf $HTTPDCONF
COPY sx /tmp/sx
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        httpd
RUN package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/sx/s2i/bin/* /s2i/ && \
    mv /tmp/sx/sx/bin/* /bin/ && \
    mv /tmp/sx/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx && \
    sed -i "s/Listen 80/#Listen 80/" $RUN_CONF && \
    rm -f $RUN_CONF_DIR/autoindex.conf $RUN_CONF_DIR/userdir.conf $RUN_CONF_DIR/welcome.conf $RUN_DIR/httpd.pid && \
    mkdir -p $APP_PATH $LOG_PATH && \
    chgrp -R 0 $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR $APP_PATH $LOG_PATH && \
    chmod -R g=u $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR $SX_S2IDIR && \
    chmod ug+r $HTTPDCONF && \
    chmod -R ugo+x /bin/sx* && \
    chmod -R ugo+rwx $LOG_PATH
COPY index.html $APP_PATH/index.html
RUN chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $LOG_PATH

CMD [ "/bin/sx-apache" , "run" ]
