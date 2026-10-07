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
cp vimrc.common ~/.vimrc.common
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

mkdir -p ~/.config/atuin
cp atuin.toml ~/.config/atuin/config.toml


has_command() {
    command -v "$1" >/dev/null 2>&1
}

install_nvim_config() {
    mkdir -p ~/.config
    rm -rf ~/.config/nvim
    cp -r nvim ~/.config/nvim
}

install_python_language_server() {
    if has_command pyright-langserver || has_command pylsp; then
        echo "Python language server already installed"
    elif has_command brew; then
        brew install pyright
    elif has_command npm; then
        npm install -g pyright
    elif has_command pipx; then
        pipx install python-lsp-server
    elif has_command python3; then
        python3 -m pip install --user python-lsp-server \
            || echo "Could not install python-lsp-server with pip"
    else
        echo "No package manager found to install a Python language server"
    fi
}

install_nvim_config
install_python_language_server
