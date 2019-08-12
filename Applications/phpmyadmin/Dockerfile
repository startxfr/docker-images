FROM startx/sv-php:centos7

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="centos7" \
    SX_TYPE="application" \
    SX_SERVICE="phpmyadmin" \
    SX_ID="startx/app-phpmyadmin" \
    SX_NAME="Startx PhpMyAdmin service image (centos 7)" \
    SX_SUMMARY="Startx phpmyadmin service based on centos 7" \
    MYSQL_LANG=fr_FR

LABEL name="$SX_ID" \
      summary="$SX_SUMMARY" \
      description="$SX_SUMMARY. Use for executing phpmyadmin database web-console or as container mainstream image for your dynamic web application containers." \
      version="$SX_VERSION" \
      release="1" \
      maintainer="Startx <dev@startx.fr>" \
      io.k8s.description="$SX_SUMMARY" \
      io.k8s.display-name="$SX_ID" \
      io.openshift.tags="startx,os,centos,apache,httpd,php,phpmyadmin,mysql,mariadb" \
      io.openshift.non-scalable="false" \
      io.openshift.wants="mysql" \
      io.openshift.min-memory="300Mi" \
      io.openshift.min-cpu="2000m" \
      io.openshift.expose-services="8080:http" \
      fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN yum install -y yum-utils && yum upgrade -y && \
    yum install -y mysql && \
    package-cleanup --problems && package-cleanup --cleandupes; package-cleanup --orphans && \
    yum remove -y --skip-broken yum-utils && \
    yum clean all --enablerepo=\* && \
    cd $APP_PATH && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/4.8.0.1/phpMyAdmin-4.8.0.1-all-languages.zip && \
    unzip phpMyAdmin-4.8.0.1-all-languages.zip && \
    rm -f phpMyAdmin-4.8.0.1-all-languages.zip && \
    mv phpMyAdmin-4.8.0.1-all-languages/* ./  && \
    rm -rf phpMyAdmin-4.8.0.1-all-languages  && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    chgrp -R 0 $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp /var/lib/php && \
    chmod -R ug+rw $APP_PATH $DATA_PATH $LOG_PATH /var/lib/php && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $DATA_PATH $LOG_PATH /var/lib/php && \
    chmod -R g=u $APP_PATH $DATA_PATH $LOG_PATH /bin/sx* /s2i $SX_LIBDIR /tmp /var/lib/php && \
    chmod -R ugo+x /bin/sx*
COPY config.inc.php $APP_PATH/config.inc.php
COPY DatabaseInterface.php $APP_PATH/libraries/classes/DatabaseInterface.php
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH && rm -rf $APP_PATH/index.html $APP_PATH/config.sample.inc.php

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

CMD [ "/bin/sx-pma" , "run" ]