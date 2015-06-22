FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN yum -y install nodejs npm python make gcc \
    && yum clean all \
    && mkdir -p /app \
    && chmod ug+rx /app
VOLUME ["/app"]
WORKDIR /app
COPY app /app
ENV MAIN_APP /app/app.js
ENV NODE_PATH /app/node_modules
