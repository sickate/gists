# mount disk on Aliyun VPS
# execute with root user
BLKDEV=$1

# 1. partition
echo -e "n\np\n1\n\n\nwq\n" | sudo fdisk -S 63 $BLKDEV

# 2. format to ext4
sudo mkfs.ext4 $BLKDEV1

# write disk partition info
echo /dev/$BLKDEV1  /mnt ext4    defaults    0  0 >> /etc/fstab

# mount and test
sudo mount -a
df
