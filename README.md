<!--
SPDX-FileCopyrightText: 2019 Harish Rajagopal <harish.rajagopals@gmail.com>

SPDX-License-Identifier: MIT
-->

# Vim Configuration

This is a repository holding my Vim configuration, including vimrc and plugins.
I use vim's default package management to manage my Vim plugins.
Therefore, Vim versions older than 8 are unsupported.

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

## Licenses
This repository uses [REUSE](https://reuse.software/) to document licenses.
Each file has a header containing copyright and license information.
The license files that are used in this project can be found in the [LICENSES](./LICENSES) directory.

The MIT license is placed in [LICENSE](./LICENSE), to signify that it constitutes the majority of the codebase, and for compatibility with GitHub.
