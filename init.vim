let g:owd = getcwd()
let g:is_unix = has('macunix') || has('unix')

let $VIM_PATH = expand('<sfile>:p:h')
cd $VIM_PATH

let $VIM_DATA_PATH = exists('*stdpath') 
  \ ? stdpath('data')
  \ : expand(($XDG_DATA_HOME ? $XDG_DATA_HOME : '~/.local/share') . '/nvim', 1)

source ./native-settings.vim
source ./config.vim
source ./mappings.vim

lua require('lazy-bootstrap')
lua require('lines')

if filereadable('./lua/local/init.lua') || filereadable('./lua/local.lua')
  lua require('local')
endif

exe 'cd ' . g:owd
