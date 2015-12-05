FROM startx/fedora:22
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN dnf -y install unoconv libreoffice-headless libreoffice-writer libreoffice-calc pdfmod ghostscript && \
    dnf clean all 
ENV STARTUPLOG=/data/logs/ooconv/startup.log \
    LOG_PATH=/data/logs/ooconv
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH  && \
    mkdir -p /tmp/ootmp  && \
    touch $STARTUPLOG

EXPOSE 2002
VOLUME [$LOG_PATH]
CMD ["/bin/run.sh"]
