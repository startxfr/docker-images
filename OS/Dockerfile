FROM centos:centos7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install pwgen tar psmisc procps findutils iputils net-tools wget logrotate zip && \
    dnf clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh && \
    mkdir /data /logs && \
    touch $STARTUPLOG

VOLUME $LOG_PATH
CMD [ "/bin/run.sh" ]
