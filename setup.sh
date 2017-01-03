#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.cache
mkdir -p ~/.vim/tmp

DOT_FILES=(
 .vimrc
 .zshrc
 .gitconfig
 .git_template/
 .config/vim/
 .config/peco/
 .tmux.conf
 .my.cnf
)

for file in ${DOT_FILES[@]}
do
  if [ -a ${HOME}/${file} ]; then
    if [ -L $HOME/$file ]; then
      rm -f ${HOME}/${file}
      ln -s ${HOME}/dotfiles/${file} ${HOME}/${file}
    elif [ -d $HOME/$file ]; then
      :
    else
      mv ${HOME}/${file} ${HOME}/${file}.bak
      ln -s ${HOME}/dotfiles/${file} ${HOME}/${file}
    fi
  else
    ln -s ${HOME}/dotfiles/${file} ${HOME}/${file}
  fi
done

