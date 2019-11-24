FROM startx/sv-apache:fc27

ENV SX_VERSION="fc27" \
    SX_TYPE="runner" \
    SX_SERVICE="apache" \
    SX_ID="startx/runner-apache" \
    SX_NAME="Startx Apache gitlab runner image (fedora 27)" \
    SX_SUMMARY="Startx apache gitlab runner based on fedora 27"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on http using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="200Mi" \
    io.openshift.min-cpu="1000m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN yum install -yq yum-utils && \
    yum upgrade -yq --refresh && \
    yum install -yq --nogpgcheck \
    make && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    yum remove -yq --skip-broken yum-utils && \
    yum clean all --enablerepo=\*

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $LOG_PATH

CMD [ "/bin/sx-apache" , "usage" ]
