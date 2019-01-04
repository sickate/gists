# install vim 8 on centos 7.4
sudo yum install gcc-c++ cmake python-devel

git clone https://github.com/vim/vim.git ~/src/
cd ~/src/vim

./configure \
--enable-multibyte \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-python3interp \
--enable-luainterp \
--with-luajit \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--without-x \
--with-compiledby="opaulochaves" \
--enable-fail-if-missing

make && sudo make install

# install dotvim & ycm
sudo yum install gcc-c++ cmake python-devel

cd ~/.vim/plugged/YouCompleteMe && python3 ./install.py
