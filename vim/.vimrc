set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'editorconfig/editorconfig-vim'

Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on


" no sounds
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set guioptions-=T " hide toolbar
set guioptions-=m " hide menu
set guioptions-=L  "remove left-hand scroll bar


set fileencodings=utf8,cp1251,koi8-r
set termencoding=utf-8
set encoding=utf-8

"  store temporary files in a central spot
set backupdir=~/.vim/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,/var/tmp,/tmp

" jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


set autoread   " reload files changed outside vim

let mapleader = " "
set notimeout
set ttimeout


syntax on " fite-type highlighting and configuration
set cursorline " underscore cursor line
set number " show line numbers
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50 " keep 50 lines of command line history
set incsearch " incremental search
set hlsearch " highlight search terms

" /-style searches now are case-sensitive only if there is a capital letter in the
" search expression
set ignorecase
set smartcase
set shortmess=atI " shorten text in "Press ENTER to continue... etc.

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smarttab
set autoindent

" show completions for ex commands
set wildmenu
set wildmode=longest:full

set clipboard=unnamedplus " use system clipboard (requires gvim)

" allow to use mouse
set mouse=a

let g:netrw_liststyle=3 " show file tree in NetRW (Explore)

" ---------------------------------------- PLUGINS CONFIG

" Solarized
set t_Co=256
if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized


" Airline
set noshowmode
set timeoutlen=50
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''


" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'



" Vim-jsx
let g:jsx_ext_required = 0

" ---------------------------------------- KEYBINDINGS
nnoremap <F12> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

nnoremap <silent> t :CtrlP<cr>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
map <Leader>d :NERDTreeToggle<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>rtw :%s/\s\+$//e<CR> " remove trailing whitespace

" silence search highlighting
nnoremap <leader>sh :nohlsearch<Bar>:echo<CR>

nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

