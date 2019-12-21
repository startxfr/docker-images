FROM startx/ubi:8

ENV SX_VERSION="ubi8" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (UBI 8)" \
    SX_SUMMARY="Startx ansible gitlab runner based on UBI 8"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on fedora and using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="500Mi" \
    io.openshift.min-cpu="800m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN dnf upgrade -yq --refresh && \
    dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --enable --add-repo https://releases.ansible.com/ansible-runner/ansible-runner.el7.repo && \
    dnf install -yq --nogpgcheck \
    make \
    python2-pip \
    python2-jinja2 \
    ansible \
    ansible-runner \
    # bubblewrap \
    rsync \
    openssh-clients \
    sshpass && \
    rpm -ivh https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.9.1-1.el7.ans.noarch.rpm  && \
    dnf clean all --enablerepo=\* && \
    useradd -s /bin/bash -m -g 0 -u 1001 ansible && \
    mkdir -p /.ansible && \
    chgrp -R 0 /.ansible && \
    chown -R 1001:0 /.ansible && \
    chmod -R g=u /.ansible

USER 1001

CMD [ "/bin/sx" , "usage" ]
