
" noremap <silent> <F11> :cal VimCommanderToggle()<CR>

" set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/qt4

" OmniCppComplete
" let OmniCpp_NamespaceSearch = 1
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_ShowAccess = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" let OmniCpp_MayCompleteDot = 1 " autocomplete after .
" let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
" let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest,preview

set nocompatible

execute pathogen#infect()


set bs=2                " Allow backspacing over everything in insert mode
"set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

" Disable jump-forward option in vim-latex 
let g:Imap_UsePlaceHolders = 0
let g:Imap_FreezeImap=1

autocmd Filetype tex setlocal nofoldenable
autocmd Filetype python  set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd Filetype javascript  set tabstop=2 expandtab shiftwidth=2 softtabstop=2

"set tabstop=4
"set expandtab
"set shiftwidth=4
"set softtabstop=4


augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

filetype indent plugin off

"filetype python indent plugin on 

set ai nocin nosi inde=

"set autoindent 
