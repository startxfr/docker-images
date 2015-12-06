FROM fedora:rawhide
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install deltarpm pwgen tar python-dnf-plugins-extras-migrate && \
    dnf-2 migrate && \
    dnf -y install psmisc procps coreutils findutils iputils net-tools wget logrotate zip && \
    dnf clean all 
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh && \
    mkdir /data && \
    mkdir /data/logs
ENV TERM=xterm

CMD ["/bin/run.sh"]
