FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install epel-release && \
    wget ftp://mirror.switch.ch/pool/4/mirror/centos/7.1.1503/cloud/x86_64/openstack-liberty/common/libunwind-1.1-3.el7.x86_64.rpm && \
    rpm -ivh libunwind-1.1-3.el7.x86_64.rpm  && \
    yum -y install mongodb mongodb-server libmongo-client rsyslog-mongodb  && \
    yum clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs  \
    DATA_PATH=/data
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $DATA_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
RUN chown -R mongodb:mongodb $DATA_PATH $LOG_PATH

EXPOSE 27017 28017
VOLUME [ $DATA_PATH , $LOG_PATH ]
CMD [ "/bin/run.sh" ]
