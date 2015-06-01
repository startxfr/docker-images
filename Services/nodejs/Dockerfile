FROM startx/fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN dnf -y install nodejs npm \
    && dnf clean all \
    && mkdir -p /app \
    && chmod ug+rx /app
VOLUME ["/app"]
WORKDIR /app
COPY app /app
ENV MAIN_APP /app/app.js
ENV NODE_PATH /app/node_modules

EXPOSE 8000
ENTRYPOINT ["node", "/app/app.js"]
