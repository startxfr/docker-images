FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install  mariadb-common mariadb-libs mariadb-config mariadb-errmsg mariadb-server mariadb \
    && yum clean all && \
    mkdir -p /tmp/sql 
ENV MY_CONF=/etc/my.cnf \
    STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs \
    DATA_PATH=/data \
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
VOLUME [ $DATA_PATH , $LOG_PATH ]
CMD [ "/bin/run.sh" ]