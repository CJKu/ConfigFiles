execute pathogen#infect()
" nnoremap <F9> :TlistToggle

" vim theme.
set nocp
filetype plugin indent on
syntax on

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Identify trailer space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" Display filename
" set modeline
" set ls=2
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set laststatus=2
set statusline=%4*%<\ %1*[%F] " Filename
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>

highlight User1 ctermfg=red ctermbg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white

" Envirement variable set up
set smartindent
set number
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2        " Number of spaces to use for each step of (auto)indent.
set expandtab           " Use the appropriate number of spaces to insert a <Tab>.
                        " Spaces are used in indents with the '>' and '<' commands
                        " and when 'autoindent' is on. To insert a real tab when
                        " expandtab' is on, use CTRL-V <Tab>.
set cursorline
set cursorcolumn
set textwidth=81        " Maximum width of text that is being inserted. A longer
                        " line will be broken after white space to get this width.
set ruler               " Show the line and column number of the cursor position,
                        " separated by a comma.
set fillchars+=vert:\   " remove | line of vsplit
set mouse=a             " Enable the use of the mouse.

" omnicppcomplete options

" -- optional --
" auto close options when exiting insert mode or moving away
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

" -- configs --
let OmniCpp_MayCompleteDot = 1      " autocomplete with .
let OmniCpp_MayCompleteArrow = 1    " autocomplete with ->
let OmniCpp_MayCompleteScope = 1    " autocomplete with ::
let OmniCpp_SelectFirstItem = 2     " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2     " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl = 1     " don't require special style of function opening braces

function! CompleteTab()
  let prec = strpart( getline('.'), 0, col('.')-1 )
  if prec =~ '^\s*$' || prec =~ '\s$'
    return "\"
  else
    return "\\"
  endif
endfunction

" map section
noremap <silent> <F4> :BufExplorer<CR>
noremap <silent> <F5> :NERDTree<CR>
noremap <silent> <F6> :FixWhitespace<CR>
"noremap <F10> :CompleteTab()
" noremap <F10>=CompleteTab()<CR>
" omni map
noremap <F11> :!`brew --prefix`/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/commontags /usr/include /usr/local/include ~/repository/mozilla-central/obj-debug/dist/include<CR>
set tags+=~/.vim/commontags
noremap <F12> :!`brew --prefix`/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=./tags
