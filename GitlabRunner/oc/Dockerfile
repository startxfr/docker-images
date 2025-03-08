FROM quay.io/startx/runner-bash:centos7

ENV SX_VERSION="centos7" \
    SX_TYPE="runner" \
    SX_SERVICE="oc" \
    SX_ID="startx/runner-oc" \
    SX_NAME="Startx OCP/K8S client gitlab runner image (Centos 7)" \
    SX_SUMMARY="Startx ocp/k8s gitlab runner based on Centos 7" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_OC_VERSION="4.8.13" \
    SX_ISTIO_VERSION="1.10.0"  \
    SX_HELM_VERSION="3.8.0"  \
    SX_ARGOCD_VERSION="2.3.0" 

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for building application based on oc or kubectl using gitlab CI runners." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,runner,openshift,kubernetes" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="100m" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,runner,openshift,kubernetes' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/centos7/GitlabRunner/oc/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/centos7/docs/img/runner-oc.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/runner-oc,docker.io/startx/runner-oc'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2025-03-04T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for building application based on oc or kubectl using gitlab CI runners." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/centos7/GitlabRunner/oc/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/centos7/GitlabRunner/oc" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY sx /tmp/
RUN yum install -yq python3-pip python3-pyOpenSSL openssl jq && \
    yum remove -yq python2-pyyaml python36-PyYAML PyYAML && \
    pip3 install --upgrade pip && \
    pip3 install -q yq && \
    cd /tmp && \
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$SX_OC_VERSION/openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    tar xzvf openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    mv oc kubectl /usr/bin/ && \
    rm -f openshift-client-linux-$SX_OC_VERSION.tar.gz && \
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$SX_OC_VERSION/openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    tar xzvf openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    mv openshift-install /usr/bin/ && \
    rm -f openshift-install-linux-$SX_OC_VERSION.tar.gz && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/v${SX_HELM_VERSION}/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh && \
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${SX_ISTIO_VERSION} TARGET_ARCH=x86_64 sh - && \
    mv istio-${SX_ISTIO_VERSION}/bin/istioctl /usr/local/bin/istioctl && \
    rm -rf istio-${SX_ISTIO_VERSION} && \
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v${SX_ARGOCD_VERSION}/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd && \
    cd -

USER 1001

CMD [ "/bin/sx" , "usage" ]
