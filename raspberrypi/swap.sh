# up/down swap size

# edit /etc/dphys-swapfile
# 2048 MB
# CONF_SWAPSIZE=2048

# restart swap service
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
