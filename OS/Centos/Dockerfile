FROM centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

# Install minimal packages
RUN yum -y install deltarpm pwgen tar \
    && yum -y update \
    && yum clean all
