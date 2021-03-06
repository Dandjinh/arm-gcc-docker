# base image
FROM centos:7.6.1810

# set time-zone to Shanghai
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo '$TZ' > /etc/timezone

# change yum mirror to aliyun
WORKDIR /etc/yum.repos.d/
RUN mv CentOS-Base.repo CentOS-Base.repo.backup
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN yum makecache

# running required command
RUN yum update -y
RUN yum install make cmake vim -y

# set chinese
RUN yum -y install kde-l10n-Chinese glibc-common
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL zh_CN.utf8

# set up ssh
RUN yum install openssh-server -y
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN sed -i 's/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# download gcc-arm-none-eabi and unzip
RUN mkdir -p /usr/local/bin/arm-gcc
WORKDIR /usr/local/bin/arm-gcc/
RUN curl -L -o arm-gcc.tar.bz2 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2?revision=d830f9dd-cd4f-406d-8672-cca9210dd220?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,8-2018-q4-major'
RUN yum install bzip2 -y
RUN tar -jxvf arm-gcc.tar.bz2
RUN rm -f arm-gcc.tar.bz2

# install fish and set default shell to fish
RUN curl -L 'https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo' > /etc/yum.repos.d/fish.repo
RUN yum install fish -y
RUN chsh -s /usr/bin/fish

# add gcc-arm-none-eabi to path
ENV PATH /usr/local/bin/arm-gcc/gcc-arm-none-eabi-8-2018-q4-major/bin:$PATH

# set working directory
RUN mkdir -p /root/workplace
WORKDIR /root/workplace

# change root password
RUN echo 'root:test' | chpasswd

# open port 22
EXPOSE 22

# start ssh service
CMD ["nohup /usr/sbin/sshd -D >/dev/null 2>&1 &"]
