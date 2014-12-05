FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install \
    mariadb-libs \
    mariadb-server \
    mariadb \
    && yum clean all \
    && mkdir -p /var/log/mysql \
    && mkdir -p /sx \
    && touch /var/log/mysql/.keep /var/lib/mysql/.keep \
    && chown -R mysql:mysql /var/log/mysql /var/lib/mysql \
    && mkdir -p /tmp/sql 
COPY sx/* /sx/
COPY *.sql /tmp/sql/
RUN chmod ug+rx /sx/mariadb* /tmp/sql \
    && chown -R mysql:mysql /sx/mariadb* /tmp/sql

EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql"]

USER mysql
# if you wan't to set root password, otherwise auto-generated
# see docker logs <containerId>
ENV mysql_newadminpwd newRootPassword


#ENDPOINT ["/sx/mariadb_run.sh"]
CMD ["/sx/mariadb_run.sh"]