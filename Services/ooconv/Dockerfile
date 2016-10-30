FROM startx/centos:6
MAINTAINER Christophe LARUE <dev@startx.fr>

USER root
RUN yum -y install unoconv libreoffice-headless libreoffice-writer libreoffice-calc pdfmod ghostscript && \
    yum clean all 
ENV STARTUPLOG=/logs/startup.log \
    LOG_PATH=/logs
COPY *.sh /bin/
RUN chmod 775 /bin/run.sh && \
    mkdir -p $LOG_PATH  && \
    mkdir -p /tmp/ootmp  && \
    touch $STARTUPLOG

EXPOSE 2002
VOLUME $LOG_PATH
CMD [ "/bin/run.sh" ]