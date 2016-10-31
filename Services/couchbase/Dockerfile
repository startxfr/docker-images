FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
ENV CB_VERSION=4.1.0-dp \
    CB_RELEASE_URL=http://packages.couchbase.com/releases/$CB_VERSION \
    CB_PACKAGE=couchbase-server-$CB_VERSION-centos7.x86_64.rpm \
    STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
RUN yum -y install initscripts python-httplib2 openssl && \
    yum clean all && \
    wget -q $CB_RELEASE_URL/$CB_PACKAGE && \
    rpm --install $CB_PACKAGE
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 11211
CMD [ "/bin/run.sh" ]
