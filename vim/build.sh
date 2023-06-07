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
if [ $? -ne 0 ]; then
    echo "Failed to install plugin"
    exit -1
fi

echo "Write the mkcsc.sh which is for cscope/ctags ..."
TARGET_MKCSC=/usr/local/bin/mkcsc.sh
if [ ! -e $TARGET_MKCSC ]
then
    sudo cp ./mkcsc.sh  $TARGET_MKCSC
    sudo chmod +x $TARGET_MKCSC
fi

COC_NVIM_DIR=$VIM_PKG_ROOT/bundle/coc.nvim
if [ -d $COC_NVIM_DIR ]; then
    echo "Specially for coc.nvim ..."
    which yarn
    if [ $? -ne 0 ]; then
        exit -1
    fi

    echo "1. cd $COC_NVIM_DIR"
    cd $COC_NVIM_DIR
    echo "2. yarn Install"
    yarn install
    echo "3. yarn build"
    yarn build
    echo "Specially for coc.nvim finished"
fi

echo "Cleanup"
rm -rf ./bundle/Vundle.vim
find $VIM_PKG_ROOT -name ".git" | xargs -I {} rm -rf {}

echo "All done"
