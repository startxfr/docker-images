FROM startx/fedora:23
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install nodejs npm python make gcc && \
    dnf clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs  \
    APP_PATH=/data \
    TMP_APP_PATH=/tmp/nodejs \
    APP_MAIN=/data/app.js
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