FROM startx/fedora:20
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install postgresql postgresql-libs postgresql-server \
    && yum clean all && \
    mkdir -p /tmp/sql 
ENV STARTUPLOG=/data/logs/postgresql/startup.log \
    LOG_PATH=/data/logs/postgresql \
    DATA_PATH=/data/postgresql \
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
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]
