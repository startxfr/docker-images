FROM startx/centos:6

ENV SX_VERSION="centos6" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (centos 6)" \
    SX_SUMMARY="Startx ansible gitlab runner based on centos 6" 

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building ansible playbooks based on centos and using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="500Mi" \
    io.openshift.min-cpu="800m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN yum install -y -q  yum-utils && \
    yum upgrade -y -q  && \
    yum install -y -q  --nogpgcheck \
    make \
    python-pip \
    ansible \
    ansible-runner \
    bubblewrap \
    rsync \
    openssh-clients \
    sshpass && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\*

USER 1001

CMD [ "/bin/sx" , "usage" ]
