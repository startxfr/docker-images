FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install httpd && \
    dnf clean all 
COPY httpd.conf /etc/httpd/conf.d/app.conf
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh /bin/sx-httpd.sh && \
    chmod ug+r /etc/httpd/conf.d/app.conf && \
    rm -f /etc/httpd/conf.d/autoindex.conf && \
    rm -f /etc/httpd/conf.d/welcome.conf && \
    mkdir /data && \
    mkdir /data/www && \
    mkdir /data/logs
COPY ./ /data/www
RUN rm -f /data/www/Dockerfile /data/www/httpd.conf /data/www/run.sh /data/www/sx-httpd.sh && \
    chown -R apache:apache /data/www /data/logs

EXPOSE 80
EXPOSE 443
VOLUME ["/data/www","/data/logs"]
CMD ["/bin/run.sh"]