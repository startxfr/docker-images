FROM quay.io/startx/runner-oc:latest

ENV SX_VERSION="latest" \
    SX_TYPE="runner" \
    SX_SERVICE="ocp-reliability" \
    SX_ID="startx/ocp-reliability" \
    SX_NAME="Startx OCP Reliability" \
    SX_SUMMARY="Startx ocp-reliability based on fedora rawhide" \
    SX_OC_VERSION="4.10.12"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing ocp-reliability test again't an openshift cluster." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
RUN dnf install -yq --nogpgcheck jq && \
    dnf clean all && \
    pip install yq && \
    git clone https://github.com/openshift/svt.git /tmp/src && \
    mv /tmp/src/reliability-v2/* $APP_PATH/ && \
    rm -rf /tmp/src && \
    cd $APP_PATH && \
    pip install -r requirements.txt && \
    curl -o /tmp/reliability.yaml https://raw.githubusercontent.com/openshift/svt/master/reliability-v2/config/example_reliability.yaml &> /dev/null && \
    mkdir /config && \
    cp /tmp/reliability.yaml /config/reliability.yaml && \
    chown 1001:0 -R /config $APP_PATH

WORKDIR $APP_PATH

USER 1001

ENTRYPOINT [ "python3" , "reliability.py", "-c" ]
CMD [ "/config/reliability.yaml" ]
