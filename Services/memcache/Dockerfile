FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install memcached && \
    yum clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 11211
CMD [ "/bin/run.sh" ]