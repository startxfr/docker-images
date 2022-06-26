FROM quay.io/startx/runner-bash:rocky8

ENV SX_VERSION="rocky8" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_UNAME="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (rocky 8)" \
    SX_SUMMARY="Startx ansible gitlab runner based on rocky 8" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_HUGO_RELEASE="0.83.1"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on rocky and using gitlab CI runners." \
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
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/rocky/GitlabRunner/ansible/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/rocky/docs/img/runner-ansible.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-ansible,docker.io/startx/runner-ansible' \
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-25T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building ansible playbooks based on rocky linux and using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/rocky/GitlabRunner/ansible/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/rocky/GitlabRunner/ansible" \
    org.opencontainers.image.vendor="STARTX"

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
    openssh-clients \
    jq && \
    alternatives --set python /usr/bin/python3 && \
    echo "alias pip=pip3" >> /etc/bashrc && \
    pip3 install -q ansible-runner ansible-lint openshift yq && \
    dnf remove -yq --skip-broken yum-utils gcc python3-devel epel-release && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el8.repo && \
    dnf install -yq --nogpgcheck ansible-runner && \
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
    usermod -d /home/ansible -m -l ${SX_UNAME} user && \
    mkdir -p /.ansible && \
    chgrp -R 0 /.ansible && \
    chown -R 1001:0 /.ansible && \
    chmod -R g=u /.ansible

USER 1001

CMD [ "/bin/sx" , "usage" ]
