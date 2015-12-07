FROM startx/sv-php
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN cd $TMP_APP_PATH && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/4.5.2/phpMyAdmin-4.5.2-all-languages.zip && \
    unzip phpMyAdmin-4.5.2-all-languages.zip && \
    rm -f phpMyAdmin-4.5.2-all-languages.zip && \
    mv phpMyAdmin-4.5.2-all-languages pma 
COPY config.inc.php $TMP_APP_PATH/pma/config.inc.php
COPY test.php $TMP_APP_PATH/pma/test.php

EXPOSE 80 443
VOLUME [$APP_PATH,$LOG_PATH]
CMD ["/bin/run.sh"]