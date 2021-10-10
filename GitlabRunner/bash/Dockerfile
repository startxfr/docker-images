FROM quay.io/startx/alpine:3

ENV SX_VERSION="alpine3" \
    SX_TYPE="runner" \
    SX_SERVICE="bash" \
    SX_ID="startx/runner-bash" \
    SX_NAME="Startx Bash gitlab runner image (alpine 3)" \
    SX_SUMMARY="Startx bash gitlab runner based on alpine 3"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on bash using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="32Mi" \
    io.openshift.min-cpu="50m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
<<<<<<< HEAD
RUN apk --no-cache add \
      make \
      sshpass \
      yamllint \
      shellcheck \
      ruby \
      ruby-etc \
      git && \
    gem install --silent mdl && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin && \
    git clone https://github.com/bats-core/bats-core.git /tmp/bats-core && \
    cd /tmp/bats-core && \
    ./install.sh /usr/local && \
    cd - && \
    rm -rf /tmp/bats-core
=======
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
        bats && \
    gem install --silent mdl && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin
>>>>>>> master

USER 1001

CMD [ "/bin/sx" , "usage" ]
