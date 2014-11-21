FROM startx/centos:7
MAINTAINER Christophe LARUE <dev@startx.fr>

# Install packages and set up sshd
RUN yum -y update \
    && yum -y install openssh-server \
    && yum clean all
RUN mkdir /var/run/sshd \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# Copy ssh keys
COPY .ssh/authorized_keys /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
ONBUILD CMD ["/usr/sbin/sshd", "-D"]
