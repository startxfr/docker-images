FROM fedora:latest
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install deltarpm pwgen tar python-dnf-plugins-extras-migrate && \
    dnf-2 migrate && \
    dnf -y install psmisc coreutils findutils wget logrotate && \
    dnf clean all 
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh

CMD ["/bin/run.sh"]
