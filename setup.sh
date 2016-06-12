#!/bin/bash

mkdir -p ~/.vim
mkdir -p ~/.vim/tmp

DOT_FILES=(
 .vimrc
 .vim/rc
 .bash_profile
 .bashrc
 .zshrc
 .gitconfig
 .git_template
 .tmux.conf
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

