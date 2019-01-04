sudo yum install -y nfs-utils nfs-utils-lib

# 设置nfs相关服务在操作系统启动时启动
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap  

# 启动nfs服务
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap 

# mount nfs on a client (need to open service nfs in firewall-cmd if disabled)
# add -vvv if encounters trouble
# run "telnet hostname 2049" before mount
# 1. mkdir
# 2. mount that dir
sudo mount -t nfs hostname:/data/hdfs /nfs/hdfs
