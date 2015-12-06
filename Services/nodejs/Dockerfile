FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install epel-release && \
    yum -y install nodejs npm python make gcc && \
    yum clean all 
ENV STARTUPLOG=/data/logs/nodejs/startup.log \
    LOG_PATH=/data/logs/nodejs  \
    APP_PATH=/data/nodejs \
    TMP_APP_PATH=/tmp/nodejs \
    APP_MAIN=/data/nodejs/app.js
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $APP_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
COPY *.json $TMP_APP_PATH/
COPY *.js $TMP_APP_PATH/
RUN cd $TMP_APP_PATH && npm install -production

EXPOSE 8000
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]
