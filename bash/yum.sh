# clean up if got conflict
sudo yum clean all
sudo rm -rf /var/cache/yum
sudo rpm --rebuilddb

# remove dupes
sudo package-cleanup --cleandupes
