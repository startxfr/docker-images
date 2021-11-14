FROM quay.io/startx/centos:8

ENV SX_VERSION="centos8" \
    SX_TYPE="runner" \
    SX_SERVICE="bash" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-bash" \
    SX_NAME="Startx Bash gitlab runner image (centos 8)" \
    SX_SUMMARY="Startx bash gitlab runner based on centos 8"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on bash using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="32Mi" \
    io.openshift.min-cpu="50m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -y --nogpgcheck epel-release && \
    dnf install -y --nogpgcheck --enablerepo="epel" \
    make \
    bubblewrap \
    rsync \
    openssh-clients \
    sshpass \
    yamllint \
    gem \
    git \
    bats && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf clean all --enablerepo=\* && \
    useradd -s /bin/bash -u ${SX_UID} -g 0 -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

CMD [ "/bin/sx" , "usage" ]
