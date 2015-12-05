FROM fedora:21
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install deltarpm pwgen tar python-dnf-plugins-extras-migrate && \
    dnf-2 migrate && \
    dnf -y install psmisc procps coreutils findutils wget logrotate zip && \
    dnf clean all 
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh && \
    mkdir /data && \
    mkdir /data/logs

CMD ["/bin/run.sh"]
