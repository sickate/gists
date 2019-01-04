#!/bin/sh

echo "Start printing localhost configurations..."
lsb_release -a
echo "Memory info"
cat /proc/meminfo | grep Mem
echo "CPU info"
tac /proc/cpuinfo | egrep -m2 '(processor|model\sname)'
echo "Disk info"
df -h | grep dev
sudo fdisk -l|egrep '(sdb|sda|sdc|sdd)'
echo "IP"
ifconfig|grep 'inet 172'
echo "Network device:"
lspci | grep Ethernet
sudo ethtool em1 | egrep 'em1|Speed'
sudo ethtool p1p2 | egrep 'p1p2|Speed'
echo "ULIMIT:"
sudo /bin/sh -c 'ulimit -a'
