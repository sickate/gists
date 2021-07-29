#!/bin/bash

sudo yum -y install wget
sudo yum -y install gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel

# 3.8 is not in CentOS repo
wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
tar xvf Python-3.8.5.tgz
cd Python-3.8*/
./configure --enable-optimizations
sudo make altinstall
