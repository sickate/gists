#!/bin/bash

sudo dnf groupinstall 'development tools'
sudo dnf install -y bzip2-devel expat-devel gdbm-devel \
    ncurses-devel openssl-devel readline-devel wget \
    sqlite-devel tk-devel xz-devel zlib-devel libffi-devel

# install python 3.8
PYTHON_VERSION=3.8.6
wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz

tar -xf Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION} 
./configure --enable-optimizations
make -j 4
sudo make altinstall

sudo pip3.8 install virtualenvwrapper


# put virtualenv env vars into .bashrc

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export WORKON_HOME='~/.virtualenv/'
source /usr/local/bin/virtualenvwrapper.sh

#创建基本环境：mkvirtualenv [环境名] --python=python3
#删除环境：rmvirtualenv [环境名]
#激活环境：workon [环境名]
#退出环境：deactivate
#列出所有环境：workon 或者 lsvirtualenv -b


## Install ruby
# See: https://ruby-china.org/wiki/rbenv-guide
sudo dnf install -y git wget gcc bzip2 openssl-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel


git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone git://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
# 使用 Ruby China 的镜像安装 Ruby, 国内用户推荐
git clone git://github.com/AndorChen/rbenv-china-mirror.git ~/.rbenv/plugins/rbenv-china-mirror

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
echo 'export RUBY_BUILD_MIRROR_URL=https://cache.ruby-china.com' >> ~/.bash_profile
