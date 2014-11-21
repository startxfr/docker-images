FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY mariadb_run.sh /bin/
RUN yum -y install \
    mariadb-libs \
    mariadb-server \
    mariadb \
    && yum clean all \
    && mkdir -p /var/log/mysql \
    && touch /var/log/mysql/.keep /var/lib/mysql/.keep \
    && chown -R mysql:mysql /var/log/mysql /var/lib/mysql \
    && chmod ug+rx /bin/mariadb_*

VOLUME ["/var/lib/mysql", "/var/log/mysql"]
USER mysql

EXPOSE 3306

#CMD ["/usr/libexec/mysqld"]
CMD ["/bin/mariadb_run.sh"]
ONBUILD CMD ["/bin/mariadb_run.sh"]