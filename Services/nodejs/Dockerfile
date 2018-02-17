FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install nodejs npm python make gcc && \
    yum clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs  \
    DATA_PATH=/data \
    APP_PATH=/app \
    APP_MAIN=/app/app.js
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $APP_PATH && \
    mkdir -p $DATA_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
COPY *.js $APP_PATH/
COPY *.json $APP_PATH/
RUN cd $APP_PATH && npm install -production

EXPOSE 8080
VOLUME $DATA_PATH
CMD [ "/bin/run.sh" ]