FROM quay.io/startx/php:ubi8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="php" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-php" \
    SX_NAME="Startx Apache-PHP gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx apache-php gitlab runner based on UBI 8"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on php using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="256Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    make \
    http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/bubblewrap-0.4.0-1.el8.x86_64.rpm \
    rsync \
    openssh-clients \
    https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm  && \
    dnf clean all --enablerepo=\* && \
    useradd -u ${SX_UID} -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

CMD [ "/bin/sx-php" , "usage" ]
