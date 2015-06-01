FROM fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install minimal packages
RUN dnf -y install python-dnf-plugins-extras-migrate deltarpm pwgen tar psmisc \
    && dnf-2 migrate \
    && dnf -y upgrade \
    && dnf clean all \
    && mkdir -p /sx 
