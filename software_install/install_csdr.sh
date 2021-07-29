# perpare tools

sudo cp ./yum_repos/cassandra.repo /etc/yum.repos.d/
sudo yum install cassandra -y

# reload daemon & start
sudo systemctl daemon-reload
sudo systemctl start cassandra
# automatically start at boot
sudo systemctl enable cassandra

# change systemctl to chk if you are on centos6
# sudo service cassandra start
# sudo chkconfig cassandra on

sudo mkdir -p /data1/cassandra/data
sudo mkdir -p /data1/cassandra/commitlog
sudo mkdir -p /data1/cassandra/saved_caches

sudo chown -R cassandra:cassandra /data1/cassandra
sudo cp ./configuration_templates/cassandra.yaml /etc/cassandra/conf/
