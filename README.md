
My configuration files for my desktop system 
============================================

Installation
------------

First you need to clone this repository into your local machine 

`mkdir ~/dotfiles`

`cd ~/dotfiles`

`git clone https://github.com/fantastic001/dotfiles.git .`

`./init.sh`

and you are done!


Additional tools
------------

Keybiding for xmag has been provided. To use it, install _xorg-xmag_.

Keybidings for MPRIS clients has been provided (play/pause, next, previous). Install _playerctl_ to use it. 

# Shell additional tools

- zoxide
- avuin
- bat
- ag
- fzf 

# Useful commands

- z - cd which does fuzzy search of previous dirs
- fzf - fuzzy search from list f files or stdin and print it to stdout
- avuin - better shell history
- ag - search in files pattern 
- agv - visual ag

# Neovim

`init.sh` copies `nvim/` to `~/.config/nvim` and installs a Python language
server (pyright, falling back to python-lsp-server). Neovim's built-in LSP
uses the first installed server listed in `nvim/lua/language_servers/catalog.lua`.

- `NVIM_LSP=off` - disable LSP
- `NVIM_LSP_PYTHON=pylsp,pyright` - override server preference order
- To add a language: add `nvim/lsp/<server>.lua` and an entry in `catalog.lua`
