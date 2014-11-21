FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY postgres_run.sh postgres_modify_pass.sh /bin/
RUN yum -y install \
    mariadb-galera-common \
    mariadb-galera-server \
    mariadb-libs \
    mariadb-server \
    mariadb \
    && yum clean all \
    && mkdir -p /var/log/mysql \
    && touch /var/log/mysql/.keep /var/lib/mysql/.keep \
    && chown -R mysql:mysql /var/log/mysql /var/lib/mysql \
    && chmod ug+rx /bin/postgres_*

VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
USER postgresql

EXPOSE 5432

#CMD ["/usr/libexec/pgsqld"]
CMD ["/bin/postgres_run.sh"]
ONBUILD CMD ["/bin/postgres_run.sh"]