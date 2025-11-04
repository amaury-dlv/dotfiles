set rtp+=~/.vim/bundle/c
set rtp+=~/.vim/bundle/cpp
set rtp+=~/.vim/bundle/llvm
set rtp+=~/.vim/bundle/colorschemes

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
set cursorline      " highlight the current line
set wildignore+=*.o,*.a,*.pyc,*.git,*.svn,*.swp,*.swo,*.swn,*.d
set tags=tags;/     " look in the parent directories for the ctags file
set nospell         " disable spell checking

" Change cursor shape based on mode (iTerm2)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
 
 " Fix moving around wrapped lines
if !has('nvim')
  map j gj
  map k gk
endif

map ,p :set paste!<CR>        " toggle paste mode
map ,l :setlocal number!<CR>  " toggle line numbers
nmap ,c	:tabclose<CR>         " close tab
map L gt                      " next tab
map H gT                      " previous taba
map <C-H> <C-W>h              " C-{H,J,K,L} to move around panes
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" Remap Caps Lock to ESC
silent !xmodmap -e "clear lock" -e "keycode 0x42 = Escape" >/dev/null 2>&1
