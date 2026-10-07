# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="flazz"
ZSH_THEME="daveverwer"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 60

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
PYTHON_AUTO_VRUN=true
PYTHON_VENV_NAMES=(env venv .venv)
PYTHON_VENV_NAME="env"

plugins=(git copybuffer copypath dotenv python)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor: nvim when installed, otherwise vim
if command -v nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
export VISUAL="$EDITOR"

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export PATH="$HOME/.local/bin:$PATH"

if which zoxide >/dev/null 2>&1; then 
    eval "$(zoxide init zsh)"
fi

if which atuin >/dev/null 2>&1; then 
    eval "$(atuin init zsh)"
fi

agv() {
  # 1. Check if an argument was passed, otherwise use an empty string
  local query="${1:-}"

  # 2. Run ag and pipe into fzf with multi-selection and context preview
  #    ag outputs formatted as: "filename:linenumber:content"
  local selections
  selections=$(ag --vimgrep --color "${query}" 2>/dev/null | fzf \
    --multi \
    --tac \
    --delimiter ':' \
    --preview '
      file=$(echo {} | cut -d: -f1)
      line=$(echo {} | cut -d: -f2)
      # Bat provides excellent code previews, cat/head/tail acts as fallback
      if command -v bat &> /dev/null; then
        bat --style=numbers --color=always --highlight-line "$line" --line-range $((line > 10 ? line - 10 : 1)):$((line + 10)) "$file"
      else
        tail -n +$((line > 10 ? line - 10 : 1)) "$file" | head -n 21
      fi
    ' \
    --preview-window='right:60%:wrap')

  # If nothing was selected, exit gracefully
  [ -z "$selections" ] && return 0

  # 3. Process each selected line and open in $EDITOR sequentially (separate processes)
  echo "$selections" | while IFS= read -r selection; do
    local file
    local line
    file=$(echo "$selection" | cut -d: -f1)
    line=$(echo "$selection" | cut -d: -f2)

    # Open the editor explicitly mapped to the interactive terminal device (/dev/tty)
    # This prevents the editor from hijacking the standard input stream loop.
    "${EDITOR:-vim}" "+${line}" "$file" </dev/tty
  done
}


fzfe() {
  F=/tmp/fzf-$RANDOM-$(date +%s)
  fzf -m > $F
  "${EDITOR:-vim}" "$F"
  zsh $F
  rm $F
}

fzfs() {
  F=/tmp/fzf-$RANDOM-$(date +%s)
  fzf -m > $F
  "${EDITOR:-vim}" "$F"
  if command -v pbcopy >/dev/null 2>&1; then 
    CLIP=pbcopy
  else
    CLIP="xclip -sel clip"
  fi
  cat $F | $CLIP
  rm $F
}


if command -v nvim 2>&1 >/dev/null; then 
    alias vim=nvim
fi
