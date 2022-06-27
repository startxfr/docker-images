FROM quay.io/startx/apache:latest

ENV SX_VERSION="latest" \
    SX_TYPE="service" \
    SX_SERVICE="php" \
    SX_ID="startx/sv-php" \
    SX_NAME="Startx Apache-PHP service image (fedora rawhide)" \
    SX_SUMMARY="Startx apache-php service based on fedora rawhide" \
    SX_MAINTAINER_MAIL="dev@startx.fr" \
    SX_PHPSESS_PATH="/var/lib/php/session" \
    SX_PHP_TMPPATH="/tmp"

LABEL name="$SX_ID" \
    summary="$SX_SUMMARY" \
    description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
    version="$SX_VERSION" \
    release="$SX_VERSION" \
    maintainer="Startx <$SX_MAINTAINER_MAIL>" \
    io.k8s.description="$SX_SUMMARY" \
    io.k8s.display-name="$SX_ID" \
    io.openshift.tags="startx,os,fedora,apache,httpd,php" \
    io.openshift.non-scalable="false" \
    io.openshift.min-memory="256Mi" \
    io.openshift.min-cpu="300m" \
    io.openshift.expose-services="$APP_PORT:http" \
    io.openshift.s2i.destination="/tmp" \
    io.openshift.s2i.scripts-url="image:///s2i" \
    io.s2i.scripts-url="image:///s2i" \
    fr.startx.component="$SX_ID:$SX_VERSION" \
    io.artifacthub.package.maintainers='[{"name":"STARTX","email":"$SX_MAINTAINER_MAIL"}]' \
    io.artifacthub.package.keywords='startx,os,fedora,apache,httpd,php' \
    io.artifacthub.package.readme-url="https://gitlab.com/startx1/containers/-/raw/master/Services/php/README.md" \
    io.artifacthub.package.logo-url='https://gitlab.com/startx1/containers/-/raw/master/docs/img/sv-php.svg' \
    io.artifacthub.package.alternative-locations='quay.io/startx/php,docker.io/startx/sv-php'\
    io.artifacthub.package.license='Apache-2.0' \
    org.opencontainers.image.created='2022-06-27T00:00:00Z' \
    org.opencontainers.image.version="$SX_VERSION" \
    org.opencontainers.image.description="$SX_SUMMARY. Use for executing application based on http-php or as container mainstream image for your dynamic web application containers." \
    org.opencontainers.image.documentation="https://docker-images.readthedocs.io/en/latest/Services/php/" \
    org.opencontainers.image.source="https://gitlab.com/startx1/containers/-/tree/master/Services/php" \
    org.opencontainers.image.vendor="STARTX"

USER root
COPY httpd.conf $HTTPDCONF
COPY php.ini /etc/php.d/sx.ini
COPY php-fpm.conf /etc/php-fpm.d/www.conf
COPY sx /tmp/
COPY index.php $APP_PATH/index.php
RUN dnf install -yq --nogpgcheck yum-utils && \
    dnf upgrade -yq --nogpgcheck --refresh && \
    dnf install -yq --nogpgcheck \
        php \
        php-cli \
        php-pear \
        php-gd \
        php-mcrypt \
        php-mysqlnd \
        php-soap \
        php-pdo \
        php-process \
        php-common \
        php-mbstring \
        php-bcmath \
        php-php-gettext \
        php-tcpdf \
        php-tcpdf-dejavu-sans-fonts \
        php-tidy && \
    package-cleanup --problems && \
    package-cleanup --orphans && \
    dnf remove -yq --skip-broken yum-utils yum && \
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
