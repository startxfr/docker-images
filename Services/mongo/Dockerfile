FROM startx/fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN dnf -y install \
    mongodb \
    mongodb-server \
    libmongo-client \
    rsyslog-mongodb \
    mongodb-mms-backup-agent \
    mongodb-mms-monitoring-agent \
    && dnf clean all \
    && mkdir -p /var/lib/mongodb \
    && touch /var/lib/mongodb/.keep 
COPY sx/* /sx/
COPY mongodb.conf /etc/mongodb.conf
RUN chmod ug+rx /sx/mongod* \
    && chown -R mongodb:mongodb /sx/mongod* /var/lib/mongodb /var/log/mongodb

EXPOSE 27017
VOLUME ["/var/lib/mongodb", "/var/log/mongodb"]

USER mongodb
#ENDPOINT ["/sx/mongod_run.sh"]
CMD ["/sx/mongod_run.sh"]
