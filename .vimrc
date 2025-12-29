" install vimplug
" https://github.com/junegunn/vim-plug 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run :PlugInstall

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdcommenter'
call plug#end()

nmap gcc <Plug>NERDCommenterToggle
vmap gc <Plug>NERDCommenterToggle

set nocompatible
filetype indent on
filetype plugin indent on
syntax on
set hidden
set wildmenu
set showcmd
set incsearch
set hlsearch
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
map Y y$
set mouse=a
set number
set termguicolors

" hi Normal guibg=NONE ctermbg=NONE
" set background=dark

let mapleader = " "

command! -nargs=* -complete=file W w <args>
command! -nargs=* -complete=file WA wa <args>
command! -nargs=* -complete=file Q q <args>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map j gj
map k gk

colorscheme onehalfdark
