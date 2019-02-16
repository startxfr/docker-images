FROM startx/sv-apache:fc29

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="fc29" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (fedora 29)" \
    SX_SUMMARY="Startx apache-php service based on fedora 29"

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
      io.openshift.expose-services="$APP_PORT:http" \
      io.openshift.s2i.destination="/tmp" \
      io.openshift.s2i.scripts-url="image:///s2i" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY php-fpm.conf /etc/php-fpm.d/www.conf
COPY sx /tmp/
RUN dnf --nogpgcheck -y install php php-cli php-pear \
        php-gd php-mcrypt php-mysqlnd php-soap \
        php-pdo php-process php-common php-mbstring \
        php-bcmath php-php-gettext php-tcpdf \
        php-tcpdf-dejavu-sans-fonts php-tidy && \
    dnf clean all && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chmod ug+r $HTTPDCONF && \
    mkdir -p $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chgrp -R 0 $APP_PATH $LOG_PATH /run/httpd /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php && \
    chmod -R ug+rw $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php && \
    chmod -R g=u $APP_PATH $LOG_PATH /run/httpd /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php && \
    chmod -R ugo+x /bin/sx*
COPY index.php $APP_PATH/index.php
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH && rm -rf $APP_PATH/index.html

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

CMD [ "/bin/sx-php" , "run" ]