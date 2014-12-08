FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install postgresql postgresql-libs postgresql-server \
    && yum clean all \
    && mkdir -p /var/log/pgsql /var/lib/pgsql \
    && touch /var/log/pgsql/.keep /var/lib/pgsql/.keep \
    && chown -R postgres:postgres /var/log/pgsql /var/lib/pgsql
# Copy startx toolkit
COPY sx/* /sx/
COPY postgresql.conf /var/lib/pgsql/postgresql.conf
RUN chmod ug+rx /sx/postgres* \
    && chown -R postgres:postgres /sx/postgresql*

USER postgres
EXPOSE 5432
VOLUME	["/var/log/pgsql", "/var/lib/pgsql"]

CMD ["/sx/postgresql_run.sh"]
