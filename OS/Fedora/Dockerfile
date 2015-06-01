FROM fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf install python-dnf-plugins-extras-migrate && dnf-2 migrate
    && dnf -y install deltarpm pwgen tar psmisc \
    && dnf -y update \
    && dnf clean all \
    && mkdir -p /sx 
