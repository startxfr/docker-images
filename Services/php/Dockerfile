FROM startx/sv-apache:centos6

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="centos6" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (centos 6)" \
    SX_SUMMARY="Startx apache-php service based on centos 6"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos,apache,httpd,php" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="300Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY sx /tmp/
RUN yum --nogpgcheck -y install php php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy php-fpm && \
    yum clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chmod ug+r $HTTPDCONF && \
    mkdir /run/php-fpm  && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp /run/php-fpm && \
    chmod -R ug+rw $APP_PATH $DATA_PATH $LOG_PATH /run/php-fpm && \
    chown -R 1001:0 /bin/sx* /s2i /var/lib/sx /tmp $APP_PATH $DATA_PATH $LOG_PATH /run/php-fpm && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i /var/lib/sx /tmp /run/php-fpm && \
    chmod -R ugo+x /bin/sx*
COPY index.php $APP_PATH/index.php
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH && rm -rf $APP_PATH/index.html

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

VOLUME $DATA_PATH

CMD [ "/bin/sx-php" , "run" ]