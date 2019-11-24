FROM startx/fedora:27

ENV SX_VERSION="fc27" \
    SX_TYPE="runner" \
    SX_SERVICE="ansible" \
    SX_ID="startx/runner-ansible" \
    SX_NAME="Startx Ansible gitlab runner image (fedora 27)" \
    SX_SUMMARY="Startx ansible gitlab runner based on fedora 27"

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
RUN yum install -yq yum-utils && \
    yum upgrade -yq --refresh && \
    yum install -yq --nogpgcheck \
    make \
    ansible && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -yq --skip-broken yum-utils && \
    yum clean all --enablerepo=\*

USER 1001

CMD [ "/bin/sx" , "usage" ]
