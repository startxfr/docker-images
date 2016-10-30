FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
ENV CB_VERSION=4.1.0-dp \
    CB_RELEASE_URL=http://packages.couchbase.com/releases/$CB_VERSION \
    CB_PACKAGE=couchbase-server-$CB_VERSION-centos7.x86_64.rpm \
    STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
RUN dnf -y install python-httplib2 openssl && \
    dnf clean all && \
    wget $CB_RELEASE_URL/$CB_PACKAGE && \
    rpm --install $CB_PACKAGE
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 8091 8092 8093 11207 11210 11211 18091 18092
VOLUME $LOG_PATH
CMD [ "/bin/run.sh" ]
