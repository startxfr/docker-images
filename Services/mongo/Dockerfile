FROM startx/fedora:20
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install mongodb mongodb-server libmongo-client rsyslog-mongodb  && \
    yum clean all 
ENV STARTUPLOG=/data/logs/mongodb/startup.log \
    LOG_PATH=/data/logs/mongodb  \
    DATA_PATH=/data/mongodb
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $DATA_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
RUN chown -R mongodb:mongodb $DATA_PATH $LOG_PATH

EXPOSE 27017 28017
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]