#!/bin/bash

cp xinitrc ~/.xinitrc
rm -rf ~/.vim/ ~/.config/ranger/
rm -rf ~/.config/powershell
cp -r awesome/ ~/.config/
cp -r vim/ ~/.vim
cp -r vimrc ~/.vimrc
cp Xdefaults ~/.Xdefaults
cp xbindkeys ~/.xbindkeysrc
cp xmodmap ~/.Xmodmap 
cp -r ranger ~/.config/ranger
cp -r qtile ~/.config
cp emacs ~/.emacs
cp tmux.conf ~/.tmux.conf
cp -r powershell ~/.config/powershell

cp -r i3/ ~/.config/
