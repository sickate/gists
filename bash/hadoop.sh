# hdfs uses user "hdfs" to create "/user/username" before you can ls your home directory

# hdfs nfs gateway
# first you have to install the nfs gateway service to one of your hdfs client
# and start the service from Ambari
# check nfsgatway
rpcinfo -p beta
#>> one line with "nfs"
showmount -e beta
#>> Export list for beta:
#>> / *

sudo mkdir /hdfs
# if runs into this error: stale file handle, run this:
# sudo umount /hdfs
sudo mount -t nfs -o vers=3,proto=tcp,nolock,noacl,sync $HOSTNAME:/ /hdfs

# count hdfs files
for i in $( hadoop fs -ls <hdfs-path> | tr -s ' ' | grep '/' | awk '{print$8}');
 do
    echo $i `hadoop fs -cat $i | wc -l`;
 done;
