
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


source ~/.vimrc.common

" Disable jump-forward option in vim-latex 
let g:Imap_UsePlaceHolders = 0
let g:Imap_FreezeImap=1

autocmd Filetype python  set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd Filetype javascript  set tabstop=2 expandtab shiftwidth=2 softtabstop=2

"set tabstop=4
"set expandtab
"set shiftwidth=4
"set softtabstop=4


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
