FROM fedora:latest
MAINTAINER Christophe LARUE <dev@startx.fr>

# Install minimal packages
RUN yum -y install deltarpm pwgen tar \
    && yum -y update \
    && yum clean all
