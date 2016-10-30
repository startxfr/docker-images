FROM startx/sv-php
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN cd $APP_PATH && \
    wget -q https://files.phpmyadmin.net/phpMyAdmin/4.5.2/phpMyAdmin-4.5.2-all-languages.zip && \
    unzip phpMyAdmin-4.5.2-all-languages.zip && \
    rm -f phpMyAdmin-4.5.2-all-languages.zip && \
    mv phpMyAdmin-4.5.2-all-languages/* ./  && \
    rm -rf phpMyAdmin-4.5.2-all-languages
COPY config.inc.php $APP_PATH/config.inc.php

EXPOSE 80 443
VOLUME [ $DATA_PATH , $LOG_PATH ]
CMD [ "/bin/run.sh" ]