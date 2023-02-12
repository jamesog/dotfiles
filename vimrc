" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Language features
if has("python")
	Plug 'python/black'
endif
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
"if has("python")
"Plug 'davidhalter/jedi-vim'		" Autocompletion, requires python
"endif
Plug 'hashivim/vim-terraform'
Plug 'plasticboy/vim-markdown'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'rust-lang/rust.vim'
Plug 'saltstack/salt-vim'
Plug 'w0rp/ale'
" Colourscheme
Plug 'sjl/badwolf'

call plug#end()

set hlsearch
set ignorecase						" Ignore case when searching
set smartcase						" but be case sensitive when needed

set number							" Line numbers
set tabstop=4						" Display tabs as 4 columns wide
set shiftwidth=4
set shiftround

set hidden							" Allow switching between buffers with unmodified changes

set cursorline						" Highlight current line

set showcmd							" Display incomplete commands
set showmatch						" Show matching brackets
set wildmenu
set wildmode=list:longest,full
set nofoldenable
set nojoinspaces					" Who wants two spaces after a , ?!

if has("termguicolors")
	set termguicolors
	if &term =~# '^screen'
		" See :h xterm-true-color
		" Enable true colours always; by default this only happens when TERM=xterm
		" In tmux this also requires terminal-overrides to set the Tc flag
		let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	endif
endif

set mouse= 							" Never use the mouse (undoes defaults.vim)

set lazyredraw

set pastetoggle=<F2>				" Because :set [no]paste is tedious

set splitright						" Open vsplits on the right, not the left
set splitbelow						" Similarly for splits, bottom, not top

" Add a column at 79 chars as a warning when writing long lines
if exists('+colorcolumn')
	set colorcolumn=79
endif

" https://begriffs.com/posts/2019-07-19-history-use-vim.html
" Protect changes between writes. Default values of updatecount
" (200 keystrokes) and updatetime (4 seconds) are fine
set swapfile
if !isdirectory($HOME . '/.vim/swap')
	call mkdir($HOME . '/.vim/swap', '', 0o700)
endif
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honour double slash at end (only for backupdir)
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big deal either way, since they
	" usually get deleted
	if !isdirectory($HOME . '/.vim/backup')
		call mkdir($HOME . '/.vim/backup', '', 0o700)
	endif
	set backupdir^=~/.vim/backup//
endif

" persist the undofile for each file
set undofile
if !isdirectory($HOME . '/.vim/undo')
	call mkdir($HOME . '/.vim/undo', '', 0o700)
endif
set undodir^=~/.vim/undo//

let mapleader=","

" (rageguy)
map q: :q

nnoremap <leader><space> :nohlsearch<CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
map <silent> <C-k> <Plug>(ale_previous_wrap)
map <silent> <C-j> <Plug>(ale_next_wrap)

" quickfix shortcuts
nmap ]q :cnext<CR>
nmap ]Q :clast<CR>
nmap [q :cprev<CR>
nmap [Q :cfirst<CR>

" Fugitive (git) shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Git blame<CR>

" toggle line numbering and gitgutter
nmap <C-N><C-N> :set invnumber<CR>:GitGutterToggle<CR>

" re-select lines after adjusting indentation
vnoremap < <gv
vnoremap > >gv

" (From https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim)
" In command mode, expand %% to the current file's directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" Open files in the current file's directory
map <leader>e :edit %%

" Use silent! here in case the colorscheme doesn't exist
" (e.g. before plugins are installed)
silent! colorscheme badwolf

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" Autocmd groups for creating sane defaults
if has("autocmd")
	augroup filetype_yaml
		au!
		au FileType yaml setlocal cursorcolumn
	augroup END
	augroup filetype_text
		au!
		au FileType text setlocal tw=78 fo+=t
	augroup END
	augroup filetype_python
		au!
		au BufNewFile,BufRead *.py setlocal sw=4 sts=4 et
		if exists("g:load_black")
			au BufWritePost *.py execute ':Black'
		endif
		au FileType python setlocal sw=4 sts=4 et
	augroup END
	augroup filetype_go
		au!
		au FileType go nmap <leader>r <Plug>(go-run)
		au FileType go nmap <leader>b <Plug>(go-build)
		au FileType go nmap <leader>t <Plug>(go-test)
		au FileType go nmap <leader>c <Plug>(go-coverage)
		au FileType go nmap <Leader>e <Plug>(go-rename)
		au FileType go nmap <Leader>l <Plug>(go-lint)
	augroup END
	augroup filetype_gitcommit
		au!
		au FileType gitcommit setlocal spell
	augroup END
endif

let g:ale_linters = {
\ 'go': ['gofmt', 'golint', 'govet', 'gopls'],
\ 'rust': ['rls'],
\}
" default is --enable-all which is a bit too much
let g:ale_go_golangci_lint_options = ''
let g:ale_go_golangci_lint_package = 1

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

let g:go_fmt_command = "gopls"
let g:go_imports_autosave = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_metalinter_autosave = 0
"let g:go_metalinter_command = "golangci-lint"

let g:pymode_folding = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0

let g:rustfmt_autosave = 1

let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

let g:vim_json_syntax_conceal = 0

match ErrorMsg '\s\+$'
