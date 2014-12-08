FROM centos:centos6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN yum -y install deltarpm pwgen tar psmisc \
    && yum -y update \
    && yum clean all \
    && mkdir -p /sx 
