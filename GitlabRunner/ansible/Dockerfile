FROM quay.io/startx/runner-bash:ubi8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_UNAME="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx ansible gitlab runner based on UBI 8" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_HUGO_RELEASE="0.83.1"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on fedora and using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,runner,ansible,automation" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="200m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,runner,ansible,automation' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/ubi8/GitlabRunner/ansible/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/ubi8/docs/img/runner-ansible.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-ansible,docker.io/startx/runner-ansible' \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building ansible playbooks based on fedora and using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/ubi8/GitlabRunner/ansible/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/ubi8/GitlabRunner/ansible" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq 'dnf-command(config-manager)' && \
    dnf install -yq --nogpgcheck \
    make \
    python3-pip \
    python3-jinja2 \
    http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/bubblewrap-0.4.0-1.el8.x86_64.rpm \
    rsync \
    curl \
    npm nodejs \
    openssh-clients \
    https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm && \
    pip3 -q install --upgrade pip && \
    pip3 -q install ansible ansible-runner openshift ansible-lint && \
    dnf remove -yq --skip-broken yum-utils && \
    npm install uuid && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin && \
    cd /tmp && \
    wget -q https://github.com/gohugoio/hugo/releases/download/v${SX_HUGO_RELEASE}/hugo_${SX_HUGO_RELEASE}_Linux-64bit.tar.gz && \
    tar xzvf hugo_${SX_HUGO_RELEASE}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin/ && \
    cd - && \
    useradd -d /home/ansible -m -u 1002 -g 0 ${SX_UNAME} && \
    mkdir -p /.ansible && \
    chgrp -R 0 /.ansible && \
    chown -R 1002:0 /.ansible && \
    chmod -R g=u /.ansible

USER 1002

CMD [ "/bin/sx" , "usage" ]
