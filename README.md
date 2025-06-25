<!--
SPDX-FileCopyrightText: 2019 Harish Rajagopal <harish.rajagopals@gmail.com>

SPDX-License-Identifier: MIT
-->

# NeoVim Configuration

This is a repository holding my NeoVim configuration, including all plugin specifications.
I use [lazy.nvim](https://lazy.folke.io/) to manage my NeoVim plugins.

The directory structure is kept as such for easy usage through GNU Stow.

## Instructions

1. Clone this repository:
```sh
git clone https://github.com/rharish101/vim-config.git
```
2. Use GNU Stow on the "config" folder:
```sh
stow -t ~ config
```

## Licenses
This repository uses [REUSE](https://reuse.software/) to document licenses.
Each file either has a header containing copyright and license information, or has an entry in the [TOML file](https://reuse.software/spec-3.3/#reusetoml) at [REUSE.toml](./REUSE.toml).
The license files that are used in this project can be found in the [LICENSES](./LICENSES) directory.

The MIT license is placed in [LICENSE](./LICENSE), to signify that it constitutes the majority of the codebase, and for compatibility with GitHub.
