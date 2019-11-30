FROM startx/sv-php

# update, install required, clean
RUN apk --no-cache add apache2 curl php7-apache2 php7 php7-phar php7-json php7-iconv php7-openssl \
    php7-ftp php7-xdebug php7-mcrypt php7-mbstring php7-soap php7-gmp php7-pdo_odbc \
    php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-pdo_pgsql php7-bcmath \
    php7-gd php7-odbc php7-pdo_mysql php7-gettext php7-xmlreader php7-xmlwriter \
    php7-tokenizer php7-xmlrpc php7-bz2 php7-curl php7-ctype php7-session php7-redis php7-exif \
    gcc-c++ make

# update pecl channels
RUN pecl update-channels

# install mongo drivers without Cyrus SASL (MongoDB Enterprise Authentication)
RUN printf "no\n" | pecl install mongo && cd /etc && echo "extension=mongo.so" >> /etc/php.d/mongo.ini

# install RockMongo
RUN cd /root && wget -q -O rockmongo-1.1.5.zip http://rockmongo.com/downloads/go?id=12 && unzip rockmongo-1.1.5.zip -d /var/www/ && rm -R /var/www/html && mv /var/www/rockmongo/ /var/www/html

# increase php upload size 
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 10M/g' /etc/php.ini && sed -i 's/post_max_size = 2M/post_max_size = 10M/g' /etc/php.ini

# expose php information
RUN echo '<?php phpInfo(); ?>' > /var/www/html/info.php

# Expose ports
EXPOSE 80

CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]