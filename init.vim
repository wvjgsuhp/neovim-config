let g:owd = getcwd()
let g:is_unix = has('macunix') || has('unix')

let $VIM_PATH = expand('<sfile>:p:h')
cd $VIM_PATH

let $LAZY = '~/.local/share/nvim/lazy'
let $VIM_DATA_PATH = exists('*stdpath')
  \ ? stdpath('data')
  \ : expand(($XDG_DATA_HOME ? $XDG_DATA_HOME : '~/.local/share') . '/nvim', 1)

source ./native-settings.vim
source ./config.vim
source ./mappings.vim

if g:is_unix == 0
  source ./windows/init.vim
endif

lua require('init')

exe 'cd ' . g:owd
