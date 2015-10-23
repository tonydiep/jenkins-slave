# Jenkins Slave on CentOS-7

FROM     centos:centos7
MAINTAINER Tony Diep "tonydiep@tonydiep.com"

# generate locale and set timezone
RUN localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN echo 'ZONE="UTC"' > /etc/sysconfig/clock && echo 'UTC=True' >> /etc/sysconfig/clock

# make sure the package repository is up to date
RUN yum install -y deltarpm epel-release
RUN yum --enablerepo=centosplus upgrade -y --skip-broken

# install ssh and other packages
RUN yum install -y initscripts openssh openssh-server openssh-clients sudo passwd sed which
RUN sshd-keygen
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN yum install -y git
RUN yum install -y maven
RUN yum install -y firefox
RUN yum install -y Xvfb
RUN yum install -y java-1.8.0-openjdk-devel

# setup default user
RUN useradd jenkins -G wheel -s /bin/bash -m
RUN echo 'jenkins:jenkins' | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]

