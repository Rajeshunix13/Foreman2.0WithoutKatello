FROM centos:7
RUN yum -y localinstall https://yum.theforeman.org/releases/2.0/el7/x86_64/foreman-release.rpm
RUN yum -y localinstall https://fedorapeople.org/groups/katello/releases/yum/3.15/katello/el7/x86_64/katello-repos-latest.rpm
RUN yum -y localinstall https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
RUN yum -y localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y localinstall https://yum.theforeman.org/client/2.0/el7/x86_64/foreman-client-release-2.0.1-1.el7.noarch.rpm
RUN yum -y install foreman-release-scl
RUN yum -y install foreman-installer sudo
WORKDIR /root
COPY ./Foreman-script.sh /root/
COPY ./Foreman-Installer.sh /root/
RUN chmod +x /root/Foreman-script.sh
RUN chmod +x  /root/Foreman-Installer.sh
RUN /root/Foreman-script.sh
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     
RUN yum clean all; \
 (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
CMD ["/usr/sbin/init"]
