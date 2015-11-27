""""""""""""""""""""""""""
""" Vundle Boilerplate """
""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/c
set rtp+=~/.vim/bundle/cpp
set rtp+=~/.vim/bundle/llvm
set rtp+=~/.vim/bundle/colorschemes
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " required
Plugin 'vim-scripts/a.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'hynek/vim-python-pep8-indent'
call vundle#end()
""" End Vundle

silent! colorscheme jellybeans

syntax on          " syntax coloring

filetype on        " enable file type detection
filetype plugin on
filetype indent on

set nocompatible

set shell=zsh

" Edition
set backspace=indent,eol,start " backspace over everything
set cpoptions+=ces$            " make the 'cw' and like commands put a $ at the end
"set formatoptions+=j           " remove comment leader when joining lines

" Search
set hlsearch        " highlight last search matches
set incsearch       " show matches as soon as possible
set ignorecase      " ignore case when searching
set smartcase       " ... except if there is one uppercase character
set wrapscan        " wrap around end of file

" Brackets
set matchpairs+=<:> " <> also are a matching pair
set showmatch       " show the matching bracket when inserting
set matchtime=3     " tenths of second to show the matching bracket

" General
set modelines=5     " enable modeline on OSX
set showcmd         " show command
set showmode        " show current mode
set timeoutlen=200  " (default 1000) time to wait when a part of a maped sequence is typped
set laststatus=2    " set the status line always on
set autowrite       " save before :next and :make
set autoread        " watch for file changes by other programs
set visualbell
set shortmess=aoOtTAI " use abbreviation when possible
set nocindent       " disable C indentation for regular files
set smartindent     " enable smart indentation
set expandtab       " use spaces instead of tabs
set nowrap          " do not split the line if it is too long
set display=uhex    " show unprintable characters as <xx>
set encoding=utf-8  " use a sane mutltibyte encoding
set scrolloff=8     " keep at least 8 lines after the cusor when scrolling
set wildmenu        " better command line completion menu
set wildignore+=*.o,*.a,*.pyc,*.git,*.svn,*.swp,*.swo,*.swn,*.d
set tags=tags;/     " look in the parent directories for the ctags file


" Change cursor shape based on mode (iTerm2)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Show trailing spaces
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
" Whitespace at the end of a line. This suppresses whitespace that has just been typed.
au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
au InsertEnter * call matchdelete(w:m1)
au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
au InsertLeave * call matchdelete(w:m2)
au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)

" Fix moving around wrapped lines
map j gj
map k gk

map ,p :set paste!<CR>        " toggle paste mode
map ,l :setlocal number!<CR>  " toggle line numbers
nmap ,c	:tabclose<CR>         " close tab
map L gt                      " next tab
map H gT                      " previous taba
map <C-H> <C-W>h              " C-{H,J,K,L} to move around panes
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" Various mapping to set indent
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" Remap Caps Lock to ESC
silent !xmodmap -e "clear lock" -e "keycode 0x42 = Escape" >/dev/null 2>&1


"""""""""""""""""""""""""""""
""" Plugins Configuration """
"""""""""""""""""""""""""""""

""" Clang-format
map <C-K> :pyf $HOME/.vim/bundle/clang-format/scripts/clang-format.py<cr>
imap <C-K> <c-o>:pyf $HOME/.vim/bundle/clang-format/scripts/clang-format.py<cr>

""" Fugitive
" Print current branch in statusline
silent! set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

""" Tagbar
nnoremap <leader>a :TagbarOpen<CR>

""" CtrlP
" , and ,m to open search
nnoremap ,, :CtrlPCurWD<CR>
nnoremap ,m :CtrlP<CR>
let g:ctrlp_max_height = 50
let g:ctrlp_max_files = 0

""" a.vim
let g:alternateExtensions_cpp = "hh,h,hpp"
let g:alternateExtensions_hh = "cpp,cc"

""" Syntastic
let g:syntastic_quiet_messages = { "type": "style" }
