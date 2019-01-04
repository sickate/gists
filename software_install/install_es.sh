#!/bin/bash

set -e # terminate after the first line that fails (returns nonzero exit code)

sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo cp ../packages/elasticsearch.repo /etc/yum.repos.d/
sudo yum install elasticsearch -y

sudo chown -R elasticsearch:elasticsearch /data /data{1..3}

sudo mv /etc/elasticsearch/elasticsearch.yml{,.orig}
sudo mv /etc/elasticsearch/jvm.options{,.orig}
sudo cp ../config_templates/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp ../config_templates/elastic_jvm.options /etc/elasticsearch/jvm.options

# uncomment this if on CentOS 7
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo grep -q -F 'LimitMEMLOCK=infinity' /usr/lib/systemd/system/elasticsearch.service || sudo awk '/Service/ { print; print "LimitMEMLOCK=infinity"; next }1' /usr/lib/systemd/system/elasticsearch.service > /tmp/elasticsearch.service && sudo cp /tmp/elasticsearch.service /usr/lib/systemd/system/elasticsearch.service
sudo /bin/systemctl daemon-reload
sudo systemctl start elasticsearch.service
#sudo systemctl stop elasticsearch.service

# uncomment this if on CentOS 6
#sudo chkconfig --add elasticsearch
#sudo -i service elasticsearch start

curl http://`hostname`:9200
