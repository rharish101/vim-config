# vim-config

This is a repository holding my vim configuration, including vimrc and plugins.
I use vim's default package management to manage my vim plugins.

The directory structure is kept as such for easy usage through GNU Stow.

## Instructions

1. Clone this repository:
```sh
git clone https://github.com/rharish101/vim-config.git
```
2. Clone all submodules:
```sh
git submodule update --init --recursive
```
3. Use GNU Stow on the "config" folder:
```sh
stow -t ~ config
```
4. Create the "undodir" directory for managing undo history for files:
```sh
mkdir ~/.vim/undodir
```
