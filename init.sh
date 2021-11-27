#!/bin/bash

cp xinitrc ~/.xinitrc
rm -rf ~/.vim/ ~/.config/ranger/
rm -rf ~/.config/powershell
rm -rf ~/.omnisharp-server
cp -r awesome/ ~/.config/
cp -r vim/ ~/.vim
cp -r vimrc ~/.vimrc
cp Xdefaults ~/.Xdefaults
cp xbindkeys ~/.xbindkeysrc
cp xmodmap ~/.Xmodmap 
cp -r ranger ~/.config/ranger
cp -r qtile ~/.config
cp emacs ~/.emacs
cp -r emacs.d ~/.emacs.d
cp tmux.conf ~/.tmux.conf
cp -r powershell ~/.config/powershell
cp -r omnisharp-server ~/.omnisharp-server


mkdir -p ~/.papertrack
cp -r papertrack/config.json ~/.papertrack/config.json

cp -r i3/ ~/.config/
mkdir -p ~/.local/bin
cp commander.sh ~/.local/bin
xbindkeys --poll-rc
