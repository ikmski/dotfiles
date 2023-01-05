# dotfiles

Managed by [chezmoi](https://www.chezmoi.io/)

## Install chezmoi
https://www.chezmoi.io/install/

ex) install binary to `/usr/local/bin`
```
$ sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
```

## Set up machine
```
$ chezmoi init git@github.com:ikmski/dotfiles.git
```

# Set up other tools

## Install zsh plugins
```
$ zplug install
```

## Install vim-plug
install according to `https://github.com/junegunn/vim-plug`
```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


