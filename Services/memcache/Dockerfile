FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

COPY memcache_run.sh /bin/
RUN yum -y install memcached \
    && yum clean all \
    && chmod ug+rx /bin/memcache_*

EXPOSE 11211

#CMD ["memcached" , "-u" ," "daemon"]
CMD ["/bin/memcache_run.sh"]
ONBUILD CMD ["/bin/memcache_run.sh"]