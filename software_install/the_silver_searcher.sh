#!/bin/sh

sudo yum install -y pcre-devel xz-devel
cd /usr/local/src
sudo git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
sudo ./build.sh
sudo make install
