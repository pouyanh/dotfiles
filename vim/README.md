# Vim
[Vim][vim] is a clone, with additions, of Bill Joy's vi text editor program for Unix

# Using this file

## Requirements
I've used [Vundle][vundle] as my vim plug-in manager

## Put the configuration file
You can link your vim config file by making a symbolic link to current file

```sh
ln -s ~/path/to/repo/dotfiles/vim/vimrc ~/.vim/vimrc
```

## Install plugins
Install required plugins:

```sh
vim +PluginInstall +qall
```

[vim]: https://www.vim.org/
[vundle]: https://github.com/VundleVim/Vundle.vim
