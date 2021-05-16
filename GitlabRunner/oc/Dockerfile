FROM quay.io/startx/alpine:3

ENV SX_VERSION="alpine3" \
    SX_TYPE="runner" \
    SX_SERVICE="oc" \
    SX_ID="startx/runner-oc" \
    SX_NAME="Startx OCP/K8S client gitlab runner image (alpine 3)" \
    SX_SUMMARY="Startx ocp/k8s gitlab runner based on alpine 3" \
    SX_OC_VERSION="4.7.3"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on oc or kubectl using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN apk --no-cache add py-pip jq && \
    pip install yq && \
    cd /tmp && \
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$SX_OC_VERSION/openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    tar xzvf openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    mv oc kubectl /usr/bin/ && \
    rm -f openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$SX_OC_VERSION/openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    tar xzvf openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    mv openshift-install /usr/bin/ && \
    rm -f openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    cd -

USER 1001

CMD [ "/bin/sx" , "usage" ]
