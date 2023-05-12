#!/bin/bash

VIM_PKG_ROOT=~/.vim

echo "Build vim packge root ~/.vim/ ..."
rm -rf $VIM_PKG_ROOT
mkdir -p $VIM_PKG_ROOT
mkdir -p $VIM_PKG_ROOT/vimrc_d

echo "Clear the ./bundle/Vundle.vim ..."
rm -rf ./bundle/Vundle.vim

echo "Clone Vundle from github ..."
#git clone https://github.com/VundleVim/Vundle.vim.git ./bundle/Vundle.vim
git clone git@github.com:VundleVim/Vundle.vim.git ./bundle/Vundle.vim

echo "Copy ./plugin, ./autoload and ./bundle ..."
cp -Rfa ./plugin $VIM_PKG_ROOT
cp -Rfa ./autoload $VIM_PKG_ROOT
cp -Rfa ./bundle $VIM_PKG_ROOT
rm -rf $VIM_PKG_ROOT/bundle/Vundle.vim/.git

echo "Building ~/.vimrc ..."
cp ./vimrc/*.vim $VIM_PKG_ROOT/vimrc_d/
cp ./vimrc/myvimrc ~/.vimrc

echo "Install all plugin(s) ..."
vim +PluginInstall +qall

echo "Write the mkcsc.sh which is for cscope/ctags ..."
TARGET_MKCSC=/usr/local/bin/mkcsc.sh
if [ ! -e $TARGET_MKCSC ]
then
    sudo cp ./mkcsc.sh  $TARGET_MKCSC
    sudo chmod +x $TARGET_MKCSC
fi

echo "All done"
