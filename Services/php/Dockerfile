FROM startx/sv-apache

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (fedora rawhide)" \
    SX_SUMMARY="Startx apache-php service based on fedora rawhide"

LABEL name="startx/$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY" \
      version="$SX_VERSION" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,fedora,apache,httpd,php" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="300Mi" \
      io.openshift.min-cpu="2000m" \
      fr.startx.component="$SX_ID"

USER root
COPY httpd.conf $HTTPDCONF
COPY lib/* /bin/
COPY php.ini /etc/php.d/sx.ini
RUN dnf -y install php php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy && \
    dnf clean all && \
    chmod 775 /bin/sx* && \
    mv /bin/run.sh /bin/sx-php && \
    chgrp -R 0 /bin/sx*.sh /bin/sx-php && \
    chmod -R g=u /bin/sx*.sh /bin/sx-php && \
    chmod ug+r $HTTPDCONF && \
    rm -f /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf
COPY ./ $APP_PATH
RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/lib $APP_PATH/*.ini && \
    chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH

EXPOSE 80 443

VOLUME $APP_PATH
VOLUME $LOG_PATH
VOLUME $DATA_PATH

ONBUILD COPY ./ $APP_PATH
ONBUILD RUN rm -rf $APP_PATH/Dockerfile $APP_PATH/httpd.conf $APP_PATH/lib $APP_PATH/*.ini &&  chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH

ENTRYPOINT [ "/bin/sx-php" ]
CMD [ "start" ]