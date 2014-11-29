FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY sx/* /sx/
RUN yum -y install \
    mariadb-libs \
    mariadb-server \
    mariadb \
        \
    psmisc \
        \
    && yum clean all \
    && mkdir -p /var/log/mysql \
    && mkdir -p /sx \
    && touch /var/log/mysql/.keep /var/lib/mysql/.keep \
    && chown -R mysql:mysql /var/log/mysql /var/lib/mysql \
    && chmod ug+rx /sx/mariadb* \
    && chown -R mysql:mysql /sx/mariadb*

USER mysql
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql"]

# if you wan't to set root password, otherwise auto-generated
# see docker logs <containerId>
ENV mysql_newadminpwd "newRootPassword"


#ENDPOINT ["/sx/mariadb_run.sh"]
CMD ["/sx/mariadb_run.sh"]