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

install_serbian_spell_file() {
    local spell_directory="${HOME}/.local/share/nvim/site/spell"
    local spell_file="${spell_directory}/sr.utf-8.spl"
    local spell_url="https://ftp.nluug.nl/pub/vim/runtime/spell/sr.utf-8.spl"
    if [[ -f "${spell_file}" ]]; then
        echo "Serbian spell file already installed"
    else
        mkdir -p "${spell_directory}"
        curl -fsSL -o "${spell_file}" "${spell_url}" \
            || echo "Could not download Serbian spell file"
    fi
}

install_nvim_plugins_and_tools() {
    if has_command nvim; then
        NVIM_TOOLS_AUTOINSTALL=off nvim --headless \
            -c 'lua require("tools.mason").install_missing_and_wait()' \
            -c 'qall' \
            || echo "Could not install Neovim plugins and tools"
    else
        echo "nvim not found, skipping plugin and tool installation"
    fi
}

install_nvim_config
install_python_language_server
install_serbian_spell_file
install_nvim_plugins_and_tools
