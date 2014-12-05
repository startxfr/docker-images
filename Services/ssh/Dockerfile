FROM startx/fedora
MAINTAINER Christophe LARUE <dev@startx.fr>

# Install packages and set up sshd
RUN yum -y update \
    && yum -y install openssh-server \
    && yum clean all 
# Copy startx toolkit
COPY sx/* /sx/
# Copy ssh keys
COPY .ssh/authorized_keys /root/.ssh/authorized_keys
RUN chmod ug+rx /sx/sshd*


EXPOSE 22
CMD ["/sx/sshd_run.sh"]