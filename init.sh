#!/bin/bash

cp xinitrc ~/.xinitrc
rm -rf ~/.vim/
cp -r awesome/ ~/.config/
cp -r vim/ ~/.vim
cp -r vimrc ~/.vimrc
cp Xdefaults ~/.Xdefaults
cp xbindkeys ~/.xbindkeysrc
cp xmodmap ~/.Xmodmap 

cp -r i3/ ~/.config/
