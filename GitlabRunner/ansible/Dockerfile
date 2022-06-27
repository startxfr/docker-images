FROM quay.io/startx/runner-bash:latest

ENV SX_VERSION="latest" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_UNAME="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (fedora rawhide)" \
    SX_SUMMARY="Startx ansible gitlab runner based on fedora rawhide" \
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
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/GitlabRunner/ansible/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/runner-ansible.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-ansible,docker.io/startx/runner-ansible'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building ansible playbooks based on fedora and using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/GitlabRunner/ansible/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/GitlabRunner/ansible" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        make \
        python3-pip \
        ansible \
        bubblewrap \
        rsync \
        curl \
        npm nodejs \
        openssh-clients \
        sshpass \
        jq && \
    pip install yq openshift ansible-lint && \
    dnf install -yq --nogpgcheck 'dnf-command(config-manager)' && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el7.repo && \
    dnf install -yq --nogpgcheck ansible-runner && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    npm install uuid && \
    dnf remove -yq --skip-broken yum-utils yum && \
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
