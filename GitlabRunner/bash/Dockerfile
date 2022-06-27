FROM quay.io/startx/fedora:latest

ENV SX_VERSION="latest" \
    SX_TYPE="runner" \
    SX_SERVICE="bash" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-bash" \
    SX_NAME="Startx Bash gitlab runner image (fedora rawhide)" \
    SX_SUMMARY="Startx bash gitlab runner based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on bash using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,runner,bash" \
    io.openshift.min-memory="32Mi" \
    io.openshift.min-cpu="50m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,runner,bash' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/GitlabRunner/bash/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/runner-bash.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-bash,docker.io/startx/runner-bash'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building application based on bash using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/GitlabRunner/bash/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/GitlabRunner/bash" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        make \
        bubblewrap \
        rsync \
        openssh-clients \
        sshpass \
        yamllint \
        gem \
        ShellCheck \
        git \
        bats \
        python3-pip \
        jq && \
    pip install yq && \
    gem install --silent mdl && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    useradd -s /bin/bash -u ${SX_UID} -g 0 -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

CMD [ "/bin/sx" , "usage" ]
