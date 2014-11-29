FROM fedora:latest
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN yum -y install deltarpm pwgen tar psmisc \
    && yum -y update \
    && yum clean all
