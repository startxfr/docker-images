FROM quay.io/startx/apache:alpine3

ENV SX_VERSION="alpine3" \
    SX_TYPE="runner" \
    SX_SERVICE="apache" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-apache" \
    SX_NAME="Startx Apache gitlab runner image (alpine 3.12)" \
    SX_SUMMARY="Startx apache gitlab runner based on alpine 3.12" \
    SX_MAINTAINER_MAIL="dev@startx.fr"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on http using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,runner,apache,httpd" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,runner,apache,httpd' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/alpine/GitlabRunner/apache/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/alpine/docs/img/runner-apache.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-apache,docker.io/startx/runner-apache' \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building application based on http using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/alpine/GitlabRunner/apache/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/alpine/GitlabRunner/apache" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN apk --no-cache add \
      make \
      sshpass \
      openssh \
      yamllint \
      git \
      jq && \
    pip3 install yq && \
    useradd -u ${SX_UID} -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $LOG_PATH

CMD [ "/bin/sx-apache" , "usage" ]
