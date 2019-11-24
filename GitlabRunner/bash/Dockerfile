FROM startx/centos:7

ENV SX_VERSION="centos7" \
    SX_TYPE="runner" \
    SX_SERVICE="bash" \
    SX_ID="startx/runner-bash" \
    SX_NAME="Startx Bash gitlab runner image (centos 7)" \
    SX_SUMMARY="Startx bash gitlab runner based on centos 7"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on bash using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="200Mi" \
    io.openshift.min-cpu="400m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN yum install -yq yum-utils && \
    yum upgrade -yq --refresh && \
    yum install -yq --nogpgcheck \
    make && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\*

USER 1001

CMD [ "/bin/sx" , "usage" ]
