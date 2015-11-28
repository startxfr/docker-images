FROM fedora:latest
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install deltarpm pwgen tar python-dnf-plugins-extras-migrate && \
    dnf-2 migrate && \
    dnf -y install psmisc coreutils findutils wget logrotate && \
    dnf clean all 
RUN mkdir -p /sx
