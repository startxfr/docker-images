FROM startx/sv-nodejs:fc30

ENV SX_VERSION="fc30" \
    SX_TYPE="runner" \
    SX_SERVICE="nodejs" \
    SX_ID="startx/runner-nodejs" \
    SX_NAME="Startx Nodejs gitlab runner image (fedora 30)" \
    SX_SUMMARY="Startx nodejs gitlab runner based on fedora 30"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on nodejs using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="200Mi" \
    io.openshift.min-cpu="1000m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    make && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\*

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "usage" ]
