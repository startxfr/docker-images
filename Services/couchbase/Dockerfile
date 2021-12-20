FROM quay.io/startx/centos:8

ENV SX_VERSION="centos8" \
    SX_TYPE="service" \
    SX_SERVICE="couchbase" \
    SX_ID="startx/sv-couchbase" \
    SX_NAME="Startx Couchbase service image (centos 8)" \
    SX_SUMMARY="Startx couchbase service based on centos 8" \
    CB_PATH=/opt/couchbase \
    DATA_PATH=/opt/couchbase/var \
    CB_VERSION=6.5.1 \
    CB_RELEASE_URL=https://packages.couchbase.com/releases/6.5.1 \
    CB_PACKAGE=couchbase-server-enterprise-6.5.1-centos8.x86_64.rpm \
    PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing database based on couchbase or as container mainstream image for your database backend containers." \
    version="$SX_VERSION" \
    release="1" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,centos,database,couchbase" \
    io.openshift.non-scalable="true" \
    io.openshift.min-memory="1Gi" \
    io.openshift.min-cpu="2000m" \
    io.openshift.expose-services="8091:console,8092:xdcr,8093:query,8094:fts,11207:scd-ssl,11210:scd-moxy,11211:data,18091:console-ssl,18092:xdcr-ssl,18093:query-ssl,18094:fts-ssl" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf upgrade -yq --refresh && \
    dnf install -yq epel-release && \
    dnf install -yq https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    rpm -ivh https://forensics.cert.org/cert-forensics-tools-release-el8.rpm && \
    dnf install -yq 'dnf-command(config-manager)' && \
    dnf install -y --nogpgcheck --enablerepo=* --disablerepo=media-* \
    python3-httplib2 \
    openssl \
    bzip2 \
    ncurses \
    ncurses-libs \
    ncurses-compat-libs \
    python3 && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf remove -yq 'dnf-command(config-manager)' && \
    dnf clean all --enablerepo=\* && \
    #echo 0 > /proc/sys/vm/swappiness && \
    echo '' >>/etc/sysctl.conf && \
    echo 'couchbase              soft    nofile                  90000' >>/etc/security/limits.conf && \
    echo 'couchbase              hard    nofile                  unlimited' >>/etc/security/limits.conf && \
    echo '#Set swappiness to 0 to avoid swapping' >>/etc/sysctl.conf && \
    echo 'vm.swappiness = 0' >>/etc/sysctl.conf && \
    #echo never > /sys/kernel/mm/transparent_hugepage/enabled && \
    #echo never > /sys/kernel/mm/transparent_hugepage/defrag && \
    wget -q $CB_RELEASE_URL/$CB_PACKAGE && \
    rpm --install $CB_PACKAGE && \
    rm -rf $CB_PACKAGE && \
    usermod -a -G 0 couchbase && \
    mkdir -p $SX_LIBDIR /s2i && \
    mkdir -p $DATA_PATH/lib/couchbase \
    $DATA_PATH/lib/couchbase/config \
    $DATA_PATH/lib/couchbase/data \
    $DATA_PATH/lib/couchbase/stats \
    $DATA_PATH/lib/couchbase/logs \
    $DATA_PATH/lib/moxi && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chmod g=u / && \
    chown -R couchbase:couchbase $DATA_PATH && \
    chgrp -R 0 $CB_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chown -R 1001:0 /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R g=u $CB_PATH /bin/sx-* /s2i $SX_LIBDIR* && \
    chmod -R ugo+x /bin/sx*

USER 1001

WORKDIR $DATA_PATH

EXPOSE 8091-8096 11207-11211 18091-18096 9100-9140 19130 21100-21300 9998-9999 

VOLUME $DATA_PATH

CMD [ "/bin/sx-couchbase" , "run" ]
