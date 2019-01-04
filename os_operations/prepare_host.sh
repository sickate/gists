#!/bin/sh

# do not run follwing code, as it will casue duplicated lines in config files
# cat ./bashrc >> ~/.bashrc
# sudo /bin/sh -c 'cat ./hosts >> /etc/hosts'

# No need at new clusters
# echo 'export LC_ALL=zh_CN.utf8' >> ~/.bash_profile

# yum installs
sudo yum -y install epel-release #  Extra Packages for Enterprise Linux, provides tools like ioping
sudo yum update -y
sudo yum install redhat-lsb slurm vim gcc openssl-devel bzip2-devel libcurl dstat ioping sysstat fio tmux rsync git htop tree zlib-devel -y
sudo yum install -y libev libev-devel # libev support for better async performance

# setup nopass login
ssh-keygen
cat ./public_keys/`whoami`_id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*
