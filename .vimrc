execute pathogen#infect()
" nnoremap <F9> :TlistToggle

" vim theme.
set nocp
filetype plugin indent on
syntax on

" Setup Solarized theme
if has('gui_running')
  set background=light
else
  set background=dark
endif

"let g:solarized_termcolors=256                " 256 color mode
colorscheme solarized

" Setup AirLine
if has('gui_running')
  set guifont=Inconsolata\ for\ Powerline:h12
endif
" make sure iterm choose powerline font!
let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#enabled = 1  " head bar.

" Setup ControlP
" Hint: how to install ControlP
"   http://kien.github.io/ctrlp.vim/#installation
"   https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim      " ControlP plugin
set wildignore+=*/tmp/*,*.so,*.swp,*.zip      " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe   " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Identify trailer space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

set laststatus=2

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
"set mouse=a             " Enable the use of the mouse.

function! CompleteTab()
  let prec = strpart( getline('.'), 0, col('.')-1 )
  if prec =~ '^\s*$' || prec =~ '\s$'
    return "\"
  else
    return "\\"
  endif
endfunction

" map section
noremap <silent> <F2> :tp<CR>
noremap <silent> <F3> :tn<CR>
noremap <silent> <F4> :BufExplorer<CR>
noremap <silent> <M-F4> :bn<CR>
noremap <silent> <S-F4> :bp<CR>
noremap <silent> <F5> :NERDTree<CR>
noremap <silent> <F6> :FixWhitespace<CR>

" au BufNewFile,BufRead *.jsm filetype=javascript
