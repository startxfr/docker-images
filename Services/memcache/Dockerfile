FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install memcached && \
    yum clean all 
ENV STARTUPLOG=/data/logs/memcache/startup.log \
    LOG_PATH=/data/logs/memcache
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG

EXPOSE 11211
VOLUME [$LOG_PATH]
CMD ["/bin/run.sh"]