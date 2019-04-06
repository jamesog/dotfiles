call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Language features
Plug 'ambv/black'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
"if has("python")
"Plug 'davidhalter/jedi-vim'		" Autocompletion, requires python
"endif
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'saltstack/salt-vim'
" Colourscheme
Plug 'sjl/badwolf'

call plug#end()

syntax on

" sensible.vim does this
"set backspace=indent,eol,start
"set encoding=utf-8

set hlsearch
set ignorecase						" Ignore case when searching
set smartcase						" but be case sensitive when needed

set number							" Line numbers
set tabstop=4						" Display tabs as 4 columns wide
set shiftwidth=4

set cursorline						" Highlight current line

set showmatch						" Show matching brackets
set wildmenu
set wildmode=list:longest,full
set nofoldenable

" I rarely use a terminal with fewer than 256 colours
set t_Co=256

set pastetoggle=<F2>				" Because :set [no]paste is tedious

set splitright						" Open vsplits on the right, not the left
set splitbelow						" Similarly for splits, bottom, not top

let mapleader=","

" Who uses ex mode?
map Q <Nop>

" (rageguy)
map q: :q

nnoremap <leader><space> :nohlsearch<CR>

nnoremap <C-t> :tabnew<CR>

" Fugitive (git) shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" toggle line numbering
nmap <C-N><C-N> :set invnumber<CR>

" Use silent! here in case the colorscheme doesn't exist
" (e.g. before Vundle plugins are installed)
silent! colorscheme badwolf

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1


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
	augroup filetype_go
		au FileType go nmap <leader>r <Plug>(go-run)
		au FileType go nmap <leader>b <Plug>(go-build)
		au FileType go nmap <leader>t <Plug>(go-test)
		au FileType go nmap <leader>c <Plug>(go-coverage)
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

let g:go_fmt_command = "goimports"
let g:go_highlight_trailing_whitespace_error = 1
let g:go_metalinter_autosave = 1

let g:pymode_folding = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
