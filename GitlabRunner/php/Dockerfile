FROM quay.io/startx/php:alpine3

ENV SX_VERSION="alpine3" \
    SX_TYPE="runner" \
    SX_SERVICE="php" \
    SX_ID="startx/runner-php" \
    SX_NAME="Startx Apache-PHP gitlab runner image (alpine 3)" \
    SX_SUMMARY="Startx apache-php gitlab runner based on alpine 3"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on php using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="256Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN apk --no-cache add make

USER 1001

CMD [ "/bin/sx-php" , "usage" ]
