
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

Shared Vim/Neovim settings live in `vimrc.common` (installed to
`~/.vimrc.common`); `vimrc` keeps only Vim plugin settings.

- `NVIM_INDENT_WIDTH=2` - change indent width (default 4 spaces)
- `NVIM_SHARED_VIMRC=path` - use a different shared settings file
- `NVIM_LSP=off` - disable LSP
- `NVIM_LSP_PYTHON=pylsp,pyright` - override server preference order
- To add a language: add an entry in `catalog.lua` (server configs come from
  nvim-lspconfig); put overrides in `nvim/after/lsp/<server>.lua`

## Plugins and tools (VS Code extension equivalents)

Plugins are installed by the built-in `vim.pack` from
`nvim/lua/plugins/catalog.lua`. Language servers and debuggers are installed
by Mason from `nvim/lua/tools/catalog.lua` (`:ToolsInstall`, or automatically
on startup).

| VS Code extension | Neovim equivalent |
| --- | --- |
| Java pack, maven, gradle, dependency | jdtls + nvim-jdtls |
| java-debug, java-test | nvim-dap + java-debug-adapter, java-test bundles |
| rust-analyzer | rust-analyzer |
| cpptools pack | clangd + codelldb (nvim-dap) |
| cmake, cmake-tools | neocmakelsp + cmake-tools.nvim (`:CMakeBuild`, ...) |
| makefile-tools | built-in `:make` |
| vscode-xml, xml-complete | lemminx |
| vscode-yaml | yaml-language-server |
| docker | dockerfile + docker-compose language servers |
| github-actions | gh-actions-language-server |
| code-spell-checker (+ Serbian) | built-in spell, `spelllang=en,sr` |
| rainbow-csv, datawrangler | rainbow_csv (RBQL queries via `:Select`) |
| java-upgrade, migrate-java-to-azure | no equivalent |

Keys: `F5` continue, `F10`/`F11`/`F12` step over/into/out, `<leader>b`
breakpoint, `<leader>du` debug UI, `<leader>dr` REPL, `<leader>dq` stop.
Java: `<leader>tc` test class, `<leader>tm` test method, `<leader>tp` pick
test, `<leader>jo` organize imports, `<leader>ju` reload Maven/Gradle project.

- `NVIM_PLUGINS=off` - do not load plugins or plugin features
- `NVIM_FEATURES_DISABLED=java,cmake` - disable features listed in
  `nvim/lua/features/catalog.lua` (filetypes, spelling, tools, debugging,
  java, cmake)
- `NVIM_TOOLS_AUTOINSTALL=off` - do not install missing tools on startup
- `NVIM_TOOLS_INSTALL_TIMEOUT_MS=600000` - headless install timeout
- `NVIM_JAVA_HOME=path` - JDK used to run jdtls (default `JAVA_HOME`, then
  Homebrew openjdk)
- `NVIM_SPELL=off`, `NVIM_SPELL_LANGUAGES=en,sr` - spell checking
- `NVIM_COMPLETION_MATCHING=fuzzy|prefix` - fzf-style fuzzy completion
  matching and ranking (default `fuzzy`)
- To add a feature: add a module with `configure()` and an entry in
  `nvim/lua/features/catalog.lua`
