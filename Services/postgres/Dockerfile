FROM startx/fedora:23
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install postgresql postgresql-libs postgresql-server \
    && dnf clean all && \
    mkdir -p /tmp/sql 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs \
    DATA_PATH=/data \
    LOADSQL_PATH=/tmp/sql 
COPY *.sh /bin/
COPY *.sql $LOADSQL_PATH/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $DATA_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG && \
    chown -R postgres:postgres $LOG_PATH $DATA_PATH $LOADSQL_PATH $STARTUPLOG && \
    chmod -R 0700 $DATA_PATH

EXPOSE 5432
VOLUME [$DATA_PATH, $LOG_PATH]
CMD ["/bin/run.sh"]
