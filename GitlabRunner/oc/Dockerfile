FROM startx/centos:6

ENV SX_VERSION="centos6" \
    SX_TYPE="runner" \
    SX_SERVICE="oc" \
    SX_ID="startx/runner-oc" \
    SX_NAME="Startx OCP/K8S client gitlab runner image (centos 6)" \
    SX_SUMMARY="Startx ocp/k8s gitlab runner based on centos 6" \
    SX_OC_VERSION="3.11.232"

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
RUN yum install -yq python-pip jq && \
    pip install yq && \
    cd /tmp && \
    wget -q https://mirror.openshift.com/pub/openshift-v3/clients/$SX_OC_VERSION/linux/oc.tar.gz && \
    tar xzvf oc.tar.gz && \
    mv oc /usr/bin/ && \
    rm -f oc.tar.gz && \
    cd -

USER 1001

CMD [ "/bin/sx" , "usage" ]
