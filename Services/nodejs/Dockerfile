FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install nodejs npm \
    && yum clean all \
    && mkdir -p /var/nodejs /var/nodejs/app \
    && chmod ug+rx /var/nodejs/app 
COPY sx/* /sx/
COPY app/* /var/nodejs/app/
RUN chmod ug+rx /sx/nodejs* 

EXPOSE 8000
VOLUME ["/var/nodejs/app"]

ENV MAIN_APP /var/nodejs/app/app.js

CMD ["/sx/nodejs_run.sh"]