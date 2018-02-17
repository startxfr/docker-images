FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install mongodb mongodb-server  && \
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
VOLUME $DATA_PATH
CMD [ "/bin/run.sh" ]