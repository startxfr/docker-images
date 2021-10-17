FROM quay.io/startx/nodejs:alpine3

ENV SX_VERSION="alpine3" \
    SX_TYPE="runner" \
    SX_SERVICE="nodejs" \
    SX_UID=1001 \
    SX_UNAME="user" \
    SX_ID="startx/runner-nodejs" \
    SX_NAME="Startx Nodejs gitlab runner image (alpine 3)" \
    SX_SUMMARY="Startx nodejs gitlab runner based on alpine 3"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on nodejs using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="64Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN apk --no-cache add \
      make \
      sshpass \
      openssh \
      yamllint \
      git && \
    useradd -u ${SX_UID} -m ${SX_UNAME} && \
    mv /tmp/bin/* /bin/ && \
    mv /tmp/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/bin /tmp/bin

USER $SX_UID

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-nodejs" , "usage" ]
