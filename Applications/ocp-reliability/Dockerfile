FROM quay.io/startx/runner-oc:latest

ENV SX_VERSION="latest" \
    SX_TYPE="application" \
    SX_SERVICE="ocp-reliability" \
    SX_ID="startx/ocp-reliability" \
    SX_NAME="Startx OCP Reliability" \
    SX_SUMMARY="Startx ocp-reliability based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_OC_VERSION="4.10.12"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing ocp-reliability test again't an openshift cluster." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,openshift,kubernetes,reliability" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,openshift,kubernetes,reliability' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Application/ocp-reliability/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/app-ocp-reliability.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/ocp-reliability,docker.io/startx/app-ocp-reliability'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing ocp-reliability test again't an openshift cluster." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Application/ocp-reliability/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Application/ocp-reliability" \
    org.opencontainers.image.vendor="STARTX"

USER root
RUN dnf install -yq --nogpgcheck jq && \
    dnf clean all && \
    pip install yq && \
    git clone https://github.com/openshift/svt.git /tmp/src && \
    mv /tmp/src/reliability-v2/* $APP_PATH/ && \
    rm -rf /tmp/src && \
    cd $APP_PATH && \
    pip install --upgrade pip && \
    pip install discord && \
    pip install -r requirements.txt && \
    curl -o /tmp/reliability.yaml https://raw.githubusercontent.com/openshift/svt/master/reliability-v2/config/example_reliability.yaml &> /dev/null && \
    mkdir /config && \
    cp /tmp/reliability.yaml /config/reliability.yaml && \
    chown 1001:0 -R /config $APP_PATH

WORKDIR $APP_PATH

USER 1001

ENTRYPOINT [ "python3" , "reliability.py", "-c" ]
CMD [ "/config/reliability.yaml" ]
