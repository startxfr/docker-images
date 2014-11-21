FROM startx/centos:centos7
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY nodejs_run.sh /bin/
RUN yum -y install nodejs npm \
    && yum clean all \
    && mkdir -p /var/www/html \
    && mkdir -p /var/log/httpd \
    && chmod ug+rx /bin/nodejs_*

WORKDIR /src
COPY app.js /src/app.js

EXPOSE 8000

#CMD ["node", "/src/app.js"]
CMD ["/bin/nodejs_run.sh"]
ONBUILD CMD ["/bin/nodejs_run.sh"]