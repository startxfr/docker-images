FROM quay.io/startx/php:latest

ENV SX_VERSION="latest" \
    SX_TYPE="application" \
    SX_SERVICE="phpmyadmin" \
    SX_ID="startx/app-phpmyadmin" \
    SX_NAME="Startx PhpMyAdmin service image (fedora rawhide)" \
    SX_SUMMARY="Startx phpmyadmin service based on fedora rawhide" \
    MYSQL_LANG=fr_FR

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing phpmyadmin database web-console or as container mainstream image for your dynamic web application containers." \
    version="$SX_VERSION" \
    release="1" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,apache,httpd,php,phpmyadmin,mysql,mariadb" \
    io.openshift.non-scalable="false" \
    io.openshift.wants="mysql" \
    io.openshift.min-memory="128Mi" \
    io.openshift.min-cpu="200m" \
    io.openshift.expose-services="8080:http" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY sx /tmp/
RUN dnf install -yq yum-utils dnf-plugin-system-upgrade && \
    dnf upgrade -yq --refresh && \
    dnf install -yq --nogpgcheck \
    mysql && \
    package-cleanup --problems && \
    package-cleanup --cleandupes; \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken dnf-plugin-system-upgrade yum-utils yum && \
    dnf clean all --enablerepo=\* && \
    cd $APP_PATH && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/4.8.0.1/phpMyAdmin-4.8.0.1-all-languages.zip && \
    unzip -q phpMyAdmin-4.8.0.1-all-languages.zip && \
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
RUN chgrp -R 0 $APP_PATH && \
    chmod -R g=u $APP_PATH && \
    rm -rf $APP_PATH/index.html $APP_PATH/config.sample.inc.php

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

CMD [ "/bin/sx-pma" , "run" ]