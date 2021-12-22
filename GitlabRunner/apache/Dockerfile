FROM quay.io/startx/apache:centos8

ENV SX_VERSION="centos8" \
    SX_TYPE="runner" \
    SX_SERVICE="apache" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-apache" \
    SX_NAME="Startx Apache gitlab runner image (centos 8)" \
    SX_SUMMARY="Startx apache gitlab runner based on centos 8"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on http using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck yum-utils && \
    dnf install -yq --nogpgcheck \
    make \
    bubblewrap \
    rsync \
    openssh-clients \
    jq && \
    pip3 install -q yq && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf clean all --enablerepo=\* && \
    useradd -u ${SX_UID} -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $LOG_PATH

CMD [ "/bin/sx-apache" , "usage" ]
