FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
ENV CB_VERSION="4.1.0" \
    CB_RELEASE_URL="http://packages.couchbase.com/releases/4.1.0-dp" \
    CB_PACKAGE="couchbase-server-4.1.0-dp-centos7.x86_64.rpm" \
    STARTUPLOG=/data/logs/couchbase/startup.log \
    LOG_PATH=/data/logs/couchbase \
    DATA_PATH=/opt/couchbase/var
RUN yum -y install initscripts python-httplib2 openssl && \
    yum clean all && \
    wget -q $CB_RELEASE_URL/$CB_PACKAGE && \
    rpm --install $CB_PACKAGE
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 8091 8092 8093 11207 11210 11211 18091 18092
VOLUME [$LOG_PATH,$DATA_PATH]
CMD ["/bin/run.sh"]
