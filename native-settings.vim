colorscheme github

set clipboard+=unnamedplus      " Yank without explicit registration
set number                      " Show current line number
set relativenumber              " Show relative line numbers
set foldmethod=expr
set mouse=nv                    " Disable mouse in command-line mode
set report=2                    " Report on line changes
set errorbells                  " Trigger bell on error
set visualbell                  " Use visual bell instead of beeping
set hidden                      " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac    " Use Unix as the standard file type
set magic                       " For regular expressions turn magic on
set path+=**                    " Directories to search when using gf and friends
set isfname-==                  " Remove =, detects filename in var=/foo/bar
set virtualedit=block           " Position cursor anywhere in visual block
set synmaxcol=2500              " Don't syntax highlight long lines
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=uselast           " Use last window with quickfix entries
set backspace=indent,eol,start  " Intuitive backspacing in insert mode

" Tabs, indents
set tabstop=2 shiftwidth=2 expandtab
set textwidth=80    " Text width maximum chars before wrapping
set softtabstop=-1  " Automatically keeps in sync with shiftwidth
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'

" Searching
set ignorecase    " Search ignoring case
set smartcase     " Keep case when searching with *
set infercase     " Adjust case in insert completion mode
set incsearch     " Incremental search
set wrapscan      " Searches wrap around the end of the file

set complete=.,w,b,k  " C-n completion: Scan buffers, windows and dictionary
set completeopt=menu,menuone,preview    " Always show menu, even for one item
set diffopt+=iwhite             " Diff mode: ignore whitespace

" Interface
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set sidescrolloff=5     " Keep at least 5 lines left/right
set noruler             " Disable default status ruler
set list                " Show hidden characters

set helpheight=0        " Disable help window resizing
set winwidth=30         " Minimum width for active window
set winminwidth=1       " Minimum width for inactive windows
set winheight=1         " Minimum height for active window
set winminheight=1      " Minimum height for inactive window

set cmdheight=0
set showtabline=0
" set noshowcmd           " Don't show command in status line
set cmdwinheight=5      " Command-line lines
" set equalalways         " Resize windows on split or close
set laststatus=2        " Always show a status line
set colorcolumn=+0      " Column highlight at textwidth's max character-limit
set display=lastline
