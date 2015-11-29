FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install nodejs npm python make gcc && \
    dnf clean all 
ENV STARTUPLOG=/data/logs/nodejs/startup.log \
    LOG_PATH=/data/logs/nodejs  \
    APP_PATH=/data/nodejs \
    APP_MAIN=/data/nodejs/app.js
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $APP_PATH && \
    mkdir -p $LOG_PATH && \
    touch $STARTUPLOG
COPY ./ $APP_PATH
RUN rm -f $APP_PATH/Dockerfile $APP_PATH/README.md $APP_PATH/run.sh $APP_PATH/docker-compose.yml

EXPOSE 8000
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]