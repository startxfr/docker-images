FROM startx/fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

RUN dnf -y install memcached memcached-selinux && dnf clean all 
COPY sx/* /sx/
RUN chmod ug+rx /sx/memcache* 

EXPOSE 11211

CMD ["/sx/memcache_run.sh"]
