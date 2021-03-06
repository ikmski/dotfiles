#!/bin/bash

mkdir -p ~/develop/
mkdir -p ~/.config/
mkdir -p ~/.cache/
mkdir -p ~/.vim/tmp/

DOT_FILES=(
 .config/memo
 .config/peco
 .config/todo
 .config/trans
 .config/twitter-cli
 .config/vim
 .git_template
 .bashrc
 .bash_profile
 .Brewfile
 .gitconfig
 .my.cnf
 .tmux.conf
 .vimrc
 .zshrc
)

for file in ${DOT_FILES[@]}
do
  if [ -a ${HOME}/${file} ]; then
    if [ -L $HOME/${file} ]; then
      rm -f ${HOME}/${file}
    else
      mv ${HOME}/${file} ${HOME}/${file}.bak
    fi
  fi
  ln -s ${HOME}/dotfiles/${file} ${HOME}/${file}
done

