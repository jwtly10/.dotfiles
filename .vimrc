" install vimplug
" https://github.com/junegunn/vim-plug 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run :PlugInstall

let mapleader = " "
let g:NERDCreateDefaultMappings = 0

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'jacoborus/tender.vim'
call plug#end()

"
" Picker
"
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --no-ignore --glob "!.git" --glob "!target" --glob "!node_modules" --glob "!dist" --glob "!build" --glob "!out" --glob "!coverage"'

command! ProjectFiles       Files
command! ProjectGitFiles    call fzf#vim#files('', {'source': 'rg --files --hidden --glob "!.git" --glob "!target" --glob "!node_modules" --glob "!dist" --glob "!build" --glob "!out" --glob "!coverage"'})
command! ProjectAllFiles    call fzf#vim#files('', {'source': 'rg --files --hidden --no-ignore'})

nnoremap <leader>pf :ProjectFiles<CR>
nnoremap <leader>pF :ProjectGitFiles<CR>
nnoremap <leader>pa :ProjectAllFiles<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pm :History<CR>
nnoremap <leader>p. :Files %:p:h<CR>
"
" LSP
"
let g:coc_inlay_hint_enable = 0
" highlight usages under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap gi <Plug>(coc-implementation)
nmap gy <Plug>(coc-type-definition)
nnoremap gt <Plug>(coc-diagnostic-info)
nnoremap K :call CocActionAsync('doHover')<CR>
nnoremap <leader>xx :CocDiagnostics<CR>

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>f <Plug>(coc-format-selected)

nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" Completions
inoremap ,, <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,; <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,: <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,= <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Copilot
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <Tab> copilot#Accept("\<CR>")

"
" Settings
"
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

" defaults to no case, but will require case if used
set ignorecase
set smartcase

" vim swap files
set directory=~/.vim/swap//

set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set signcolumn=no
map Y y$
set mouse=a
set nonumber
set termguicolors
set splitright
" Stop auto commenting new lines
autocmd BufEnter * set formatoptions-=cro
autocmd BufEnter * setlocal formatoptions-=cro

hi Normal guibg=NONE ctermbg=NONE
set background=dark

" Better status line coloring, inherit background
"hi StatusLine   ctermbg=236 ctermfg=NONE cterm=bold
"hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=NONE
"hi StatusLine ctermbg=none cterm=bold

" Window Split
"hi VertSplit ctermfg=WHITE ctermbg=NONE

"
" Basic KB
"
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

nnoremap <leader>\ :nohl<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map j gj
map k gk

set t_Co=16


"
" Colors
"

"augroup NoBold
  "autocmd!
  "autocmd ColorScheme * highlight clear
  "autocmd ColorScheme * syntax reset
  "autocmd ColorScheme * for group in getcompletion('', 'highlight') |
        "\ execute 'highlight ' . group . ' cterm=NONE gui=NONE' |
        "\ endfor
"augroup END

"hi CocErrorHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Red cterm=underline
"hi CocWarningHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Yellow cterm=underline
"hi CocInfoHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Cyan cterm=underline
"hi CocHintHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Gray cterm=underline
"hi CocUnusedHighlight guifg=NONE guibg=NONE gui=strikethrough guisp=Gray cterm=underline
"hi CocDeprecatedHighlight guifg=NONE guibg=NONE gui=strikethrough guisp=Gray cterm=underline


syntax enable
colorscheme tender
