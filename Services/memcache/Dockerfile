FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install memcached && \
    dnf clean all 
ENV STARTUPLOG=/data/logs/memcache/startup.log \
    LOG_PATH=/data/logs/memcache
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 11211
CMD ["/bin/run.sh"]