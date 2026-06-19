" install vimplug
" https://github.com/junegunn/vim-plug 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run :PlugInstall

let mapleader = " "
let g:NERDCreateDefaultMappings = 0

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
call plug#end()

"
" Picker
"
let g:ctrlp_map = '<leader>pf'
"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlP .'
" working path is project
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 0
let g:ctrlp_extensions = []
" use ripgrep if on system
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --glob "!.git" --glob "!target" --glob "!node_modules" --glob "!dist" --glob "!build"'
endif

" Project files
nnoremap <leader>pf :CtrlP .<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMRU<CR>
" Find relative file (searches dir of buffer)
nnoremap <leader>p. :CtrlP %:p:h<CR>

" Show git-ignored files, but still omit build dirs
command! ProjectAllFiles call ctrlp#init(ctrlp#command#init(
      \ 'rg --files --hidden --no-ignore
      \ --glob "!.git"
      \ --glob "!target"
      \ --glob "!node_modules"
      \ --glob "!dist"
      \ --glob "!build"
      \ --glob "!out"
      \ --glob "!coverage"'))
nnoremap <leader>pF :ProjectAllFiles<CR>


" UI Defaulting
hi CtrlPMatch guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPLinePre guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPMode1 guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPMode2 guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPStats guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPPrtBase guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPPrtText guifg=white guibg=NONE ctermfg=white ctermbg=NONE
hi CtrlPPrtCursor guifg=white guibg=NONE ctermfg=white ctermbg=NONE
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

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>f <Plug>(coc-format-selected)

nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

hi CocErrorHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Red cterm=underline
hi CocWarningHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Yellow cterm=underline
hi CocInfoHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Cyan cterm=underline
hi CocHintHighlight guifg=NONE guibg=NONE gui=undercurl guisp=Gray cterm=underline
hi CocUnusedHighlight guifg=NONE guibg=NONE gui=strikethrough guisp=Gray cterm=underline
hi CocDeprecatedHighlight guifg=NONE guibg=NONE gui=strikethrough guisp=Gray cterm=underline

" Completions
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
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
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set signcolumn=no
map Y y$
set mouse=a
set number
set termguicolors
set splitright
" Stop auto commenting new lines
autocmd BufEnter * set formatoptions-=cro
autocmd BufEnter * setlocal formatoptions-=cro

hi Normal guibg=NONE ctermbg=NONE
set background=dark

" Better status line coloring, inherit background
hi StatusLine   ctermbg=236 ctermfg=NONE cterm=bold
hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=NONE
"hi StatusLine ctermbg=none cterm=bold

" Window Split
"hi VertSplit guifg=#282a2c guibg=NONE
hi VertSplit ctermfg=WHITE ctermbg=NONE
"hi VertSplit ctermfg=236 ctermbg=NONE

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
