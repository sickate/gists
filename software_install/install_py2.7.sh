# install python 2.7
sudo cp Python-2.7.14.tgz /usr/src
cd /usr/src
sudo tar xzf Python-2.7.14.tgz
cd Python-2.7.14
sudo ./configure --enable-optimizations
sudo make altinstall

sudo ln -sf /usr/local/bin/python2.7 /usr/bin/python2.7
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python2.7 get-pip.py
sudo ln -sf /usr/local/bin/pip /usr/bin/pip
sudo pip install cqlsh
cd ~/scripts
#sudo python2.7 setup.py install --user


