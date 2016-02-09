FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install nodejs npm python make gcc && \
    dnf clean all 
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
COPY *.json $APP_PATH/
COPY *.js $APP_PATH/
RUN cd $APP_PATH && npm install -production

EXPOSE 8000
VOLUME [$DATA_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]