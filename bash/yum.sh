# clean up if got conflict
sudo yum clean all
sudo rm -rf /var/cache/yum
sudo rpm --rebuilddb

# remove dupes
sudo package-cleanup --cleandupes

# list installed
yum list installed


# useful
# for lsb_release -a
sudo yum install -y redhat-lsb

# for htop
sudo yum -y install epel-release #  Extra Packages for Enterprise Linux, provides tools like ioping
sudo yum update -y
sudo yum install redhat-lsb slurm vim gcc openssl-devel bzip2-devel libcurl dstat ioping sysstat fio tmux rsync git htop tree zlib-devel perf telnet bcc -y
sudo yum install -y libev libev-devel # libev support for better async performance
