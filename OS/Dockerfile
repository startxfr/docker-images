FROM centos:centos6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN yum -y install deltarpm pwgen tar && \
    yum -y install psmisc procps coreutils findutils iputils net-tools wget logrotate zip && \
    yum clean all 
COPY *.sh /bin/
RUN chmod 775 /bin/sx-lib.sh /bin/run.sh && \
    mkdir /data && \
    mkdir /data/logs
ENV TERM=xterm

CMD ["/bin/run.sh"]
