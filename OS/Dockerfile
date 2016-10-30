FROM centos:centos6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN yum -y install deltarpm pwgen tar initscripts psmisc procps coreutils findutils iputils net-tools wget logrotate zip && \
    yum clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh && \
    mkdir /data /logs && \
    touch $STARTUPLOG

VOLUME $LOG_PATH
CMD [ "/bin/run.sh" ]
