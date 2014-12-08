FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
# Install packages and set up unoconv
RUN yum -y install unoconv libreoffice-headless libreoffice-writer libreoffice-calc pdftk gs \
    && yum clean all \
    && mkdir -p /tmp/ootmp 
# Copy startx toolkit
COPY sx/* /sx/
RUN chmod ug+rx /sx/ooconv*

EXPOSE 2002
VOLUME ["/tmp/ootmp"]

CMD ["/sx/ooconv_run.sh"]
