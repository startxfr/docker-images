FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install memcached && \
    dnf clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 11211
VOLUME $LOG_PATH
CMD [ "/bin/run.sh" ]