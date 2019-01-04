#!/bin/bash

# change centos7 to centos6 if on 6
sudo yum -y update
sudo yum -y install yum-utils
sudo yum -y groupinstall development
sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo yum -y install python36u
sudo yum -y install python36u-pip
sudo yum -y install python36u-devel
sudo pip3.6 install --upgrade pip
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple requests pandas scipy numpy urllib3 cassandra-driver ipython scikit-learn
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple scales # for Cassandra metrics capturing
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple lz4 # for Cassandra compression
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple Cython
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple pyyaml
sudo pip3.6 install --index-url https://mirrors.aliyun.com/pypi/simple hdfs
