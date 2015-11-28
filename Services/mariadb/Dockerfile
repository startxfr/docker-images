FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install  mariadb-common mariadb-libs mariadb-config mariadb-errmsg mariadb-server mariadb \
    && dnf clean all \
    && mkdir -p /var/logs/mariadb \
    && touch /var/logs/mariadb/.keep /var/lib/mariadb/.keep \
    && chown -R mariadb:mariadb /var/logs/mariadb /var/lib/mariadb \
    && mkdir -p /tmp/sql 
ENV STARTUPLOG=/data/logs/mariadb/startup.log
COPY *.sh /bin/
COPY *.sql /tmp/sql/
RUN chmod 775 /bin/run.sh && \
    mkdir /data && \
    mkdir /data/mariadb && \
    mkdir /data/logs && \
    mkdir /data/logs/mariadb && \
    touch $STARTUPLOG
COPY ./ /data/www
RUN rm -f /data/www/Dockerfile /data/www/httpd.conf /data/www/run.sh /data/www/sx-httpd.sh && \
    chown -R apache:apache /data/www /data/logs
RUN chmod ug+rx /sx/mariadb* /tmp/sql \
    && chown -R mysql:mysql /sx/mariadb* /tmp/sql

EXPOSE 3306
VOLUME ["/data/mariadb", "/var/logs/mariadb"]

CMD ["/sx/run.sh"]