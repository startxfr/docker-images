FROM quay.io/startx/centos:8

ENV SX_VERSION="centos8" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (centos 8)" \
    SX_SUMMARY="Startx ansible gitlab runner based on centos 8" \
    SX_HUGO_RELEASE="0.72.0"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on centos and using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="200m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq 'dnf-command(config-manager)' epel-release && \
    dnf makecache  && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el8.repo && \
    dnf install -yq --nogpgcheck \
    make \
    ansible \
    python3-pip \
    bubblewrap \
    rsync \
    gcc python3-devel \
    curl \
    npm nodejs \
    openssh-clients && \
    alternatives --set python /usr/bin/python3 && \
    echo "alias pip=pip3" >> /etc/bashrc && \
    pip3 install -q ansible-runner && \
    pip3 install -q openshift && \
    dnf remove -yq --skip-broken yum-utils gcc python3-devel epel-release && \
    dnf install -yq --nogpgcheck 'dnf-command(config-manager)' && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el7.repo && \
    dnf install -yq --nogpgcheck ansible-runner && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    npm install uuid && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin && \
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
