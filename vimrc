set nocompatible					" I'm using vim, I want its features!
filetype off						" Required at this stage by Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Vim enhancements
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
" Language features
Plugin 'fatih/vim-go'
Plugin 'davidhalter/jedi-vim'		" Autocompletion
Plugin 'klen/python-mode'
Plugin 'saltstack/salt-vim'
" Colourscheme
Plugin 'sjl/badwolf'

call vundle#end()

syntax on
filetype plugin indent on

" sensible.vim does this
"set backspace=indent,eol,start
"set encoding=utf-8

set hlsearch
set ignorecase						" Ignore case when searching
set smartcase						" but be case sensitive when needed

set number							" Line numbers
set tabstop=4						" Display tabs as 4 columns wide
set shiftwidth=4
set showmatch						" Show matching brackets
set wildmode=list:longest,full

" I rarely use a terminal with fewer than 256 colours
set t_Co=256

set pastetoggle=<F2>				" Because :set [no]paste is tedious

let mapleader=","

" Who uses ex mode?
map Q <Nop>

" (rageguy)
map q: :q

nnoremap <leader><space> :nohlsearch<CR>

" Fugitive (git) shortcuts
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gb :Gblame<CR>

" Use silent! here in case the colorscheme doesn't exist
" (e.g. before Vundle plugins are installed)
silent! colorscheme badwolf

" Add a column at 79 chars as a warning when writing long lines
if exists('+colorcolumn')
	set colorcolumn=79
endif

" Autocmd groups for creating sane defaults
if has("autocmd")
	augroup filetype_text
		au!
		au FileType text setlocal tw=78 fo+=t
	augroup END
	augroup filetype_python
		au!
		au BufNewFile,BufRead *.py setlocal sw=4 sts=4 et
		au FileType python setlocal sw=4 sts=4 et
	augroup END
endif

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_symbols.branch = '⎇'
