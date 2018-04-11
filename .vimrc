"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
source ~/.bundle.vim

syntax on
colorscheme ron
set backspace=indent,eol,start

set cursorline
set cursorcolumn

hi CursorLine ctermfg=yellow ctermbg=green cterm=bold
hi CursorColumn ctermfg=yellow ctermbg=green cterm=bold

set noswapfile
set nobackup
set incsearch
set nu
set hlsearch
set nowrapscan

filetype indent on
set cindent

set tabstop=8
set shiftwidth=8
set noexpandtab
set nocompatible

autocmd BufRead *.py set expandtab | set tabstop=4 | set shiftwidth=4

hi TabLineFill ctermfg=gray ctermbg=DarkGreen
hi TabLine ctermfg=black ctermbg=gray
hi TabLineSel ctermfg=black ctermbg=green

set wrap
set list
set listchars=tab:>-,trail:-

set hidden
set showcmd
set ignorecase
set laststatus=2
set statusline=%F%m%r,\ %Y,\ [%{&fileformat}],\ [%{getcwd()}],\ row=%l,\ col=%c%V,\ %p%%,\ [%{(&fenc==\"\")?&enc:&fenc}],\ ASCII=\%b,\ HEX=\%B

noremap <C-t> :Tlist<CR>
noremap <C-b> :bprevious<CR>
noremap <C-n> :bnext<CR>
noremap <C-q> :Bclose<CR>
noremap <C-s> :w<CR>

inoremap <C-t> <ESC>:Tlist<CR>
inoremap <C-b> <ESC>:bnext<CR>
inoremap <C-q> <ESC>:Bclose<CR>
inoremap <C-s> <ESC>:w<CR>

imap <C-h> <Left>
imap <C-l> <Right>
"imap <C-b> <C-Left>
"imap <C-f> <C-Right>
imap <C-j> <Down>
imap <C-k> <Up>

imap <C-o> <ESC>

imap <C-e> <End>
imap <C-a> <Home>

"set the ctrlp search dir to the pwd
let g:ctrlp_working_path_mode = 'w'

"autocmd BufRead Makefile set noexpandtab
"autocmd BufRead *.mk set noexpandtab

let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 0
let Tlist_WinWidth = 50

":echo @%                def/my.txt       directory/name of file
":echo expand('%:t')     my.txt           name of file ('tail')
":echo expand('%:p')     /abc/def/my.txt  full path
":echo expand('%:p:h')   /abc/def         directory containing file ('head')

set completeopt=menu,menuone

"bufline
let g:buftabline_indicators = 1
let g:buftabline_numbers = 1
