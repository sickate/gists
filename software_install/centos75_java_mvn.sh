#!/bin/bash 

sudo yum install java-1.8.0-openjdk-devel

# no need to set PATH, since alternatives handles it.
sudo alternatives --config java
sudo ln -sf /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64 /opt/java8
sudo sh -c "echo export JAVA_HOME=/opt/java8 >> /etc/environment"
sudo sh -c "echo export JRE_HOME=/opt/java8/jre >> /etc/environment"

# install maven
mkdir ~/packages
cd !$
wget ftp://shanghai/pub/apache-maven-3.6.0-bin.tar.gz
tar xvf apache-maven-3.6.0-bin.tar.gz
sudo mv ~/packages/apache-maven-3.6.0 /opt
sudo chown -R root:root /opt/apache-maven-3.6.0
sudo ln -s /opt/apache-maven-3.6.0 /opt/apache-maven

echo 'export PATH=$PATH:/opt/apache-maven/bin' | sudo tee -a /etc/profile
source /etc/profile
