FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY mongo_run.sh /bin/
RUN yum -y install \
    mongodb \
    mongodb-server \
    libmongo-client \
    rsyslog-mongodb \
    mongodb-mms-backup-agent \
    mongodb-mms-monitoring-agent \
    && yum clean all \
    && mkdir -p /var/lib/mongodb \
    && touch /var/lib/mongodb/.keep \
    && chown -R mongod:mongod /var/lib/mongodb \
    && chmod ug+rx /bin/mongo_* 

VOLUME ["/var/lib/mongodb"]
USER mongod


EXPOSE 27017
#CMD ["/usr/bin/mongod", "--config", "/etc/mongodb.conf"]
CMD ["/bin/mongo_run.sh"]
ONBUILD CMD ["/bin/mongo_run.sh"]