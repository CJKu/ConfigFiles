execute pathogen#infect()
syntax on
filetype plugin indent on
nnoremap <F9> :TlistToggle
set number

" color torte

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" call BufExplorer
noremap <silent> <F4> :BufExplorer<CR>
noremap <silent> <F5> :NERDTree<CR>
noremap <silent> <F6> :FixWhitespace<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim

" Identify trailer space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" Display filename
set modeline
set ls=2
