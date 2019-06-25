# vim-config

This is a repository holding my vim configuration, including vimrc and plugins.
I use [pathogen](https://github.com/tpope/vim-pathogen) to manage my vim plugins.

The directory structure is kept as such for easy usage through GNU Stow.

## Instructions

1. Clone this repository:
```
git clone https://github.com/rharish101/vim-config.git
```
2. Use GNU Stow on the `config` folder:
```
stow -t ~ config
```
3. Create the `undodir` directory for managing undo history for files:
```
mkdir ~/.vim/undodir
```
