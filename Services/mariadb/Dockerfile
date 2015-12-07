FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
COPY mariadb.repo /etc/yum.repos.d/mariadb.repo
RUN yum -y remove mysql-server mysql && \
    yum -y install mysql-server mysql \
    && yum clean all && \
    mkdir -p /tmp/sql 
ENV MY_CONF=/etc/my.cnf \
    STARTUPLOG=/data/logs/mariadb/startup.log \
    LOG_PATH=/data/logs/mariadb \
    DATA_PATH=/data/mariadb \
    LOADSQL_PATH=/tmp/sql 
COPY *.sh /bin/
COPY my.cnf $MY_CONF
COPY *.sql $LOADSQL_PATH/
RUN chmod 775 /bin/run.sh && \
    chmod ug+r $MY_CONF && \
    mkdir -p $DATA_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG && \
    touch $DATA_PATH/.keep && \
    chown -R mysql:mysql $LOG_PATH $DATA_PATH $LOADSQL_PATH

EXPOSE 3306
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]