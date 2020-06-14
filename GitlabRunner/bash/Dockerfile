FROM quay.io/startx/ubi:8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="bash" \
    SX_ID="startx/runner-bash" \
    SX_NAME="Startx Bash gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx bash gitlab runner based on UBI 8"

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
RUN dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    make \
    http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/bubblewrap-0.3.0-1.el8.x86_64.rpm \
    rsync \
    openssh-clients \
    https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm && \
    dnf clean all --enablerepo=\*

USER 1001

CMD [ "/bin/sx" , "usage" ]
