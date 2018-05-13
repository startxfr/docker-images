FROM startx/sv-php:centos6

MAINTAINER Startx <dev@startx.fr>

ENV SX_VERSION="centos6" \
    SX_TYPE="application" \
    SX_SERVICE="phpmyadmin" \
    SX_ID="startx/app-phpmyadmin" \
    SX_NAME="Startx PhpMyAdmin service image (centos 6)" \
    SX_SUMMARY="Startx phpmyadmin service based on centos 6"

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
RUN cd $APP_PATH && \
    yum --nogpgcheck -y install unzip && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/4.7.7/phpMyAdmin-4.7.7-all-languages.zip && \
    unzip phpMyAdmin-4.7.7-all-languages.zip && \
    rm -f phpMyAdmin-4.7.7-all-languages.zip && \
    mv phpMyAdmin-4.7.7-all-languages/* ./  && \
    rm -rf phpMyAdmin-4.7.7-all-languages  && \
    mv /tmp/sx/bin/* /bin/ && \
    mv /tmp/sx/lib/* /var/lib/sx/ && \
    chgrp -R 0 /bin/sx* && \
    chown -R 1001:0 /bin/sx* && \
    chmod -R g=u /bin/sx* && \
    chmod -R ugo+x /bin/sx*
COPY config.inc.php $APP_PATH/config.inc.php
RUN chgrp -R 0 $APP_PATH && chmod -R g=u $APP_PATH && rm -rf $APP_PATH/index.html

USER 1001

WORKDIR $APP_PATH

EXPOSE 8080

CMD [ "/bin/sx-pma" , "start" ]