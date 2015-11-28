FROM fedora:latest
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN yum -y install deltarpm pwgen tar psmisc coreutils findutils wget logrotate \
    && yum -y update \
    && yum clean all \
    dnf -y install python-dnf-plugins-extras-migrate && dnf-2 migrate && \
    dnf clean all 
RUN mkdir -p /sx
