FROM startx/sv-apache:latest

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (fedora rawhide)" \
    SX_SUMMARY="Startx apache-php service based on fedora rawhide"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,apache,httpd,php" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="300Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY lib/* /bin/
COPY .s2i/bin/* /s2i/
COPY php.ini /etc/php.d/sx.ini
RUN dnf -y install php php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy && \
    dnf clean all && \
    chmod -R 775 /bin/sx* /s2i && \
    mv /bin/sx.sh /bin/sx-php && \
    chgrp -R 0 /bin/sx*.sh /bin/sx-php && \
    chmod -R g=u /bin/sx*.sh /bin/sx-php && \
    chmod ug+r $HTTPDCONF
COPY ./ $APP_PATH
RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/lib $APP_PATH/*.ini && \
    chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $APP_PATH
VOLUME $LOG_PATH
VOLUME $DATA_PATH

CMD [ "/bin/sx-php" , "start" ]
