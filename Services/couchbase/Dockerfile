FROM startx/fedora:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="couchbase" \
    SX_ID="startx/sv-couchbase" \
    SX_NAME="Startx Couchbase service image (fedora rawhide)" \
    SX_SUMMARY="Startx couchbase service based on fedora rawhide" \
    CB_PATH=/opt/couchbase \
    DATA_PATH=$CB_PATH/var \
    CB_VERSION=5.1.0 \
    CB_RELEASE_URL=http://packages.couchbase.com/releases/5.1.0 \
    CB_PACKAGE=couchbase-server-enterprise_5.1.0-centos7.x86_64.rpm \
    PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing database based on couchbase or as container mainstream image for your database backend containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,database,couchbase" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="8000m" \
      io.openshift.expose-services="8091:couchbase" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf -y install python-httplib2 openssl && \
    dnf clean all && \
    wget $CB_RELEASE_URL/$CB_PACKAGE && \
    rpm --install $CB_PACKAGE && \
    groupadd -g 1001 couchbase && useradd couchbase -u 1001 -g couchbase -M && \
    mkdir -p $DATA_PATH /opt/couchbase/var/lib/couchbase \
        /opt/couchbase/var/lib/couchbase/config \
        /opt/couchbase/var/lib/couchbase/data \
        /opt/couchbase/var/lib/couchbase/stats \
        /opt/couchbase/var/lib/couchbase/logs \
        /opt/couchbase/var/lib/moxi && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    touch $DATA_PATH/.keep && \
    chown -R couchbase:couchbase $DATA_PATH /opt/couchbase/var && \
    chgrp -R 0 $CB_PATH /bin/sx-* /s2i /var/lib/sx* && \
    chown -R 1001:0 /bin/sx-* /s2i /var/lib/sx* && \
    chmod -R g=u $CB_PATH /bin/sx-* /s2i /var/lib/sx*

USER 1001

WORKDIR $DATA_PATH

EXPOSE 8091 8092 8093 8094 11207 11210 11211 18091 18092 18093 18094

VOLUME $DATA_PATH

CMD [ "/bin/sx-couchbase" , "start" ]