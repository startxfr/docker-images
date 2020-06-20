FROM quay.io/startx/ubi:8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx ansible gitlab runner based on UBI 8"
    SX_HUGO_RELEASE="0.72.0"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on fedora and using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="200m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN dnf upgrade -yq --refresh && \
    dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el8.repo && \
    dnf install -yq --nogpgcheck \
    make \
    python3-pip \
    python3-jinja2 \
    http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/bubblewrap-0.3.0-1.el8.x86_64.rpm \
    rsync \
    openssh-clients \
    https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm && \
    dnf install -yq --nogpgcheck --skip-broken python3-ansible-runner ansible-runner && \
    pip3 install --user ansible && \
    dnf clean all --enablerepo=\* && \
    cd /tmp && \
    wget -q https://github.com/gohugoio/hugo/releases/download/v${SX_HUGO_RELEASE}/hugo_${SX_HUGO_RELEASE}_Linux-64bit.tar.gz && \
    tar xzvf hugo_${SX_HUGO_RELEASE}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin/ && \
    cd - && \
    useradd -s /bin/bash -m -g 0 -u 1001 ansible && \
    mkdir -p /.ansible && \
    chgrp -R 0 /.ansible && \
    chown -R 1001:0 /.ansible && \
    chmod -R g=u /.ansible

USER 1001

CMD [ "/bin/sx" , "usage" ]
