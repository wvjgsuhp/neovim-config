let g:owd = getcwd()
cd ~/.config/nvim

let g:indent_guides_enable_on_vim_startup = 1
" let $VIM_PATH = expand('<sfile>:p:h')

source ./native-settings.vim
source ./config.vim
source ./mappings.vim

lua require('lazy-bootstrap')
lua require('lines')

exe 'cd ' . g:owd
