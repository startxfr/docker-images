

FROM       startx/centos:centos6
MAINTAINER startx dev@startx.fr

CMD rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
CMD yum install --skip-broken -y --enablerepo=rpmforge unoconv libreoffice-headless libreoffice-writer libreoffice-calc
COPY unoconv /unoconv

EXPOSE [2002]

CMD ./unoconv --listener
