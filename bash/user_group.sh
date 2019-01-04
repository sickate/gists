# add user
sudo useradd -G wheel -m -s /bin/bash newuser

# add user to existing group
sudo usermod -G hadoop -a newuser

