FROM quay.io/startx/apache:rocky8

ENV SX_VERSION="rocky8" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (rocky 8)" \
    SX_SUMMARY="Startx apache-php service based on rocky 8" \
    SX_PHPSESS_PATH="/var/lib/php/session" \
    SX_PHP_TMPPATH="/tmp"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <dev@startx.fr>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,rocky,apache,httpd,php" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="256Mi" \
    io.openshift.min-cpu="300m" \
    io.openshift.expose-services="$APP_PORT:http" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION"

USER root
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY php-fpm.conf /etc/php-fpm.d/www.conf
COPY sx /tmp/
COPY index.php $APP_PATH/index.php
RUN dnf upgrade -yq --refresh && \
    dnf install -yq epel-release && \
    dnf install -yq https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf install -yq https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    dnf install -yq 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled remi && \
    dnf config-manager --set-enabled epel && \
    dnf install -yq --nogpgcheck \
        php \
        php-cli \
        php-pear \
        php-gd \
        php-mysqlnd \
        php-soap \
        php-pdo \
        php-process \
        php-common \
        php-mbstring \
        php-bcmath && \
    dnf remove -yq --skip-broken yum-utils && \
    dnf remove -yq 'dnf-command(config-manager)' && \
    dnf clean all --enablerepo=\* && \
    mv /tmp/s2i/bin/* /s2i/ && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* $SX_LIBDIR/ && \
    rm -rf /tmp/sx /tmp/s2i && \
    chmod ug+r $HTTPDCONF && \
    mkdir -p $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php $SX_PHPSESS_PATH && \
    chgrp -R 0 $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php $SX_PHPSESS_PATH && \
    chmod -R ug+rw $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php $SX_PHPSESS_PATH && \
    chown -R 1001:0 /bin/sx* /s2i $SX_LIBDIR /tmp $APP_PATH $LOG_PATH /run/php-fpm /var/lib/php $SX_PHPSESS_PATH && \
    chmod -R g=u $APP_PATH $LOG_PATH $RUN_DIR /bin/sx* /s2i $SX_LIBDIR /tmp /run/php-fpm /var/lib/php $SX_PHPSESS_PATH && \
    chmod -R ugo+x /bin/sx* && \
    rm -rf $APP_PATH/index.html

USER 1001

WORKDIR $APP_PATH

EXPOSE $APP_PORT

VOLUME $SX_PHPSESS_PATH

CMD [ "/bin/sx-php" , "run" ]
