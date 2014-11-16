FROM fedora:latest
MAINTAINER Chistophe LARUE <dev@startx.fr>

# Install packages and set up sshd
RUN yum -y update && yum clean all
RUN yum -y install openssh-server && yum clean all
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

# Add ssh keys
ADD .ssh/authorized_keys /root/.ssh/authorized_keys

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]