#!/bin/bash

check_for_directory(){
    if [[ -d ~/.$1 ]]
    then
        rm -rf ~/.$1
        cp -r $1 ~/.$1
    else
        echo $1 not found
    fi
}


cp xinitrc ~/.xinitrc

rm -rf ~/.vim/ ~/.config/ranger/
rm -rf ~/.config/powershell
#rm -rf ~/.omnisharp-server
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

check_for_directory omnisharp-server

mkdir -p ~/.papertrack
cp -r papertrack/config.json ~/.papertrack/config.json

cp -r i3/ ~/.config/
mkdir -p ~/.local/bin
cp commander.sh ~/.local/bin
xbindkeys --poll-rc


# Installing oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp zshrc ~/.zshrc 


is_osx() {
    if [ "$(uname)" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

if is_osx; then 
    cp vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json

else 
    cp vscode-settings.json ~/.config/Code/User/settings.json
fi 