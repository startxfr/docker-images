FROM startx/sv-apache:alpine3

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="alpine3" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (alpine 3.8)" \
    SX_SUMMARY="Startx apache-php service based on alpine 3.8"

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,alpine,apache,httpd,php" \
      io.openshift.non-scalable="false" \
      io.openshift.min-memory="300Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-services="$APP_PORT:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY php-fpm.conf /etc/php-fpm.d/www.conf
COPY sx /tmp/
RUN apk --no-cache add php7-apache2 php7 php7-phar php7-json php7-iconv php7-openssl \
    php7-ftp php7-xdebug php7-mcrypt php7-mbstring php7-soap php7-gmp php7-pdo_odbc \
	php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-pdo_pgsql php7-bcmath \
	php7-gd php7-odbc php7-pdo_mysql php7-gettext php7-xmlreader php7-xmlwriter \
	php7-tokenizer php7-xmlrpc php7-bz2 php7-curl php7-ctype php7-session php7-redis php7-exif && \
    cp /usr/bin/php7 /usr/bin/php && rm -f /var/cache/apk/* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chmod ug+r $HTTPDCONF && \
    mkdir -p $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chgrp -R 0 $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php && \
    chmod -R ug+rw $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chmod -R g=u $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php && \
    chmod -R ugo+x /bin/sx*
COPY index.php $APP_PATH/index.php
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH && rm -rf $APP_PATH/index.html

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

CMD [ "/bin/sx-php" , "run" ]