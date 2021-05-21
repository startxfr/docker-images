FROM quay.io/startx/nodejs:centos8

ENV SX_VERSION="centos8" \
    SX_TYPE="runner" \
    SX_SERVICE="nodejs" \
    SX_ID="startx/runner-nodejs" \
    SX_NAME="Startx Nodejs gitlab runner image (centos 8)" \
    SX_SUMMARY="Startx nodejs gitlab runner based on centos 8"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on nodejs using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="64Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    make \
    bubblewrap \
    rsync \
    openssh-clients \
    sshpass && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "usage" ]
