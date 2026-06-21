
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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! ToggleContextHeaderPrefix()
	let l:lnum = line('.')
	let l:txt = getline(l:lnum)

	if l:txt =~ '^\s*X ====='
		call setline(l:lnum, substitute(l:txt, '^\(\s*\)X \(=====\)', '\1\2', ''))
	elseif l:txt =~ '^\s*====='
		call setline(l:lnum, substitute(l:txt, '^\(\s*\)\(=====\)', '\1X \2', ''))
	endif
endfunction

function! JumpToNextContextHeader()
	let l:lnum = line('.')
	let l:next = search('^\s*\(X \)\?=====', 'W')
	if l:next > 0
		execute l:next
	endif
endfunction
function! JumpToPrevContextHeader()
	let l:lnum = line('.')
	let l:prev = search('^\s*\(X \)\?=====', 'bW')
	if l:prev > 0
		execute l:prev
	endif
endfunction

command! ToggleContextHeader call ToggleContextHeaderPrefix()

autocmd BufRead,BufNewFile context let &l:foldmethod = 'expr' | let &l:foldexpr = "getline(v:lnum)=~'^\\(X \\)\\?====='?'>1':'='"
autocmd BufRead,BufNewFile context syntax match ContextDone /\[DONE\]/ | highlight default link ContextDone DiffAdd



" lines starting with X ===== should have forced green background (whole line)
autocmd BufRead,BufNewFile context syntax match ContextHeaderGreen /^X =====.*/ | highlight! ContextHeaderGreen cterm=NONE ctermfg=White ctermbg=Magenta guifg=#000000 guibg=#00aa00 gui=NONE
" lines starting with ===== should have forced blue background (whole line)
autocmd BufRead,BufNewFile context syntax match ContextHeaderBlue /^=====.*/ | highlight! ContextHeaderBlue cterm=NONE ctermfg=White ctermbg=Blue gui=NONE guifg=#ffffff guibg=#005f87
autocmd BufRead,BufNewFile context nnoremap <buffer> <silent> <leader>x :call ToggleContextHeaderPrefix()<CR>
autocmd BufRead,BufNewFile context nnoremap <buffer> <silent> <leader>n :call JumpToNextContextHeader()<CR>
autocmd BufRead,BufNewFile context nnoremap <buffer> <silent> <leader>p :call JumpToPrevContextHeader()<CR>

" Unfold all by default
autocmd BufRead,BufNewFile context normal! zR
