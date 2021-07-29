#!/bin/sh

# do not run follwing code, as it will casue duplicated lines in config files
# cat ./bashrc >> ~/.bashrc
# sudo /bin/sh -c 'cat ./hosts >> /etc/hosts'

# No need at new clusters
# echo 'export LC_ALL=zh_CN.utf8' >> ~/.bash_profile

# yum installs
sudo yum -y install epel-release #  Extra Packages for Enterprise Linux, provides tools like ioping
sudo yum update -y
sudo yum install redhat-lsb slurm vim gcc openssl-devel bzip2-devel libcurl dstat ioping sysstat fio tmux rsync git htop tree zlib-devel perf telnet bcc -y
sudo yum install -y libev libev-devel # libev support for better async performance

# centos 7.7 上发现上面这种装不了 htop 了，需要手动，参考
# http://cheapwindowsvps.com/blog/how-to-install-htop-on-centos-7/?__cf_chl_jschl_tk__=9d6102e0c4eb8c5adc3d012ee868fe5b29a3f108-1581772396-0-Ac8Z8NnQm0Uwo_8-yx0KvulJxddi6eWnWPvr_wHTcnbyv5mTBpslezqUp1XCjlIqrUAblUhxJ4WVLwH0kDpQuwk3wspmB62lboRVlMN5bEHDi-a2sea4xj2koeeA7slxAz7u1dfyzgI_W0SEb19-BEs6MejtMFbjDhnswaec7lAyIvA1hsfi_aBTTOYwykcOhoXDF15Vw1PMK9Kusm8DshhTJYafujXbPxf8Iyb_vAHIOtNqwAWwBAeB1jPReoQWIoIc_r39-gwDSdU6OmtbG8F0YpBnw2oT1MZ5WlafwwBzI54cdhR7QXnSZSNRlzmZAs9MsAjjFKp8R_t99Rx3dXzm9XvYJgUO0PkTRr3as9U6qHrfBsuM281Em8L_nWx62Q

# jdk tools
sudo yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel


# setup nopass login
ssh-keygen
cat ./public_keys/`whoami`_id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*
