FROM quay.io/startx/nodejs:ubi8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="nodejs" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-nodejs" \
    SX_NAME="Startx Nodejs gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx nodejs gitlab runner based on UBI 8" \
    SX_MAINTAINER_MAIL="dev@startx.fr"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on nodejs using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,runner,nodejs" \
    io.openshift.min-memory="64Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,runner,nodejs' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/ubi8/GitlabRunner/nodejs/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/ubi8/docs/img/runner-nodejs.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-nodejs,docker.io/startx/runner-nodejs'
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building application based on nodejs using gitlab CI runners." \
    org.opencontainers.image.created='2022-06-25T00:00:00Z' \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/ubi8/GitlabRunner/nodejs/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/ubi8/GitlabRunner/nodejs" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
# RUN dnf upgrade -yq --refresh
RUN dnf install -yq --nogpgcheck \
    make \
    http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/bubblewrap-0.4.0-1.el8.x86_64.rpm \
    rsync \
    openssh-clients \
    https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm && \
    dnf clean all --enablerepo=\* && \
    useradd -u ${SX_UID} -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "usage" ]
