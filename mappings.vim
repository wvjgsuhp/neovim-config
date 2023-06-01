let mapleader=' '
let maplocalleader=';'

" move between open and close brackets
nnoremap <backspace> %
vnoremap <backspace> %
onoremap <backspace> %

" Folding
nnoremap <Leader><Leader> za

" Fast saving from all modes
nnoremap <Leader>w <cmd>silent! w<CR>
nnoremap <Leader>nw <cmd>noautocmd w<CR>
nnoremap <Leader>W <cmd>noautocmd w<CR>
nmap <C-s> <space>w
xmap <C-s> <space>w
cmap <C-s> <space>w

" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>zz

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> <cmd>wincmd k<CR>
nmap <silent> <c-j> <cmd>wincmd j<CR>
nmap <silent> <c-h> <cmd>wincmd h<CR>
nmap <silent> <c-l> <cmd>wincmd l<CR>

" Yank
nnoremap <Leader>yfn <cmd>let @+=expand("%:t")<CR>
  \ <cmd>echo 'Yanked filename: <c-r>+'<CR>
nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR>
  \ <cmd>echo 'Yanked relative path: <c-r>+'<CR>
nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR>
  \ <cmd>echo 'Yanked absolute path: <c-r>+'<CR>
nnoremap <localleader>y "+y
vnoremap <localleader>y "+y

" Paste
nnoremap <Leader>piw viwpyiw
nnoremap <Leader>pa ggVGp
command! -range -nargs=1 VisualPaste call utils#visualPaste(<args>)
xnoremap p :VisualPaste 'p'<CR>
xnoremap P :VisualPaste 'P'<CR>
nnoremap <localleader>p "+p
nnoremap <localleader>P "+P
vnoremap <localleader>p :VisualPaste '"+p'<CR>
nnoremap <localleader>v "+p
nnoremap <localleader>V "+P
vnoremap <localleader>v :VisualPaste '"+p'<CR>

" Go to tab by number
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 <cmd>tablast<cr>

" Jump to the beginning/end of a line
noremap <Leader>h ^
nnoremap <Leader>l $
onoremap <Leader>l $
xnoremap <Leader>l $h

" Terminal
noremap <Leader>zz <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><cmd>terminal<cr>13<c-w>_i
nmap <Leader>zl <cmd>vsplit<cr> zz
command! ToggleTerminal call interface#ToggleTerminal()
nnoremap <Leader>` <cmd>ToggleTerminal<cr>
nnoremap <Leader>z4 :term<cr>:vs<cr>:term<cr>:sp<cr>:term<cr>:wincmd h<cr>:sp<cr>:term<cr>

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^>

nnoremap <Leader>yaa ggyG''
nnoremap <Leader>ypG VGyGp

" Delete current file
nnoremap <Leader>rm <cmd>silent! write<bar>call delete(expand('%'))<bar>b#<bar>bd#<cr>

" Close current buffer
nnoremap <Leader>bd <cmd>b#<bar>bd#<CR>

" Git
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Find
nmap <Leader>fp /<C-r>0<cr>
nnoremap <Leader>fn <cmd>Navbuddy<cr>
nmap * *N

" Edit file
nnoremap <Leader>ze <cmd>e ~/.zshrc<cr>

" Center focused line
let line_moved_commands = ['u', 'e', '<c-r>', 'n', 'N', 'G', 'w', 'b', '``']
for cmd in line_moved_commands
  execute 'nmap <silent> '.cmd.' '.cmd.'zz'
  execute 'vmap <silent> '.cmd.' '.cmd.'zz'
endfor

vmap <silent> j jzz
vmap <silent> k kzz
cmap <expr> <cr> getcmdtype() =~ '^[/?]$' ? '<cr>zz' : '<cr>'

nnoremap <Leader>zr <cmd>res 13<cr>

" Print messages to buffer
nnoremap <Leader>mb <cmd>put =execute('messages')<cr>
nmap <Leader>ml <cmd>vs<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<cr> mb
nmap <Leader>mj <cmd>sp<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<cr> mb

" quit
nnoremap <Leader>cc <cmd>cclose<cr>
augroup quit_on_non_file
  autocmd!
  autocmd FileType lazy,help,NvimTree,checkhealth,Trouble,noice,fugitiveblame nnoremap <buffer> <esc> <cmd>q<cr>
  autocmd FileType lazy,help,NvimTree,checkhealth,Trouble,noice,fugitiveblame nmap <buffer> q <esc>
augroup END

" csv specific
augroup csv
  autocmd!
  autocmd FileType csv nnoremap <buffer> <Leader>ptt <cmd>%s/\|/\t/g<cr>
  autocmd FileType csv nnoremap <buffer> <Leader>ttp <cmd>%s/\t/\|/g<cr>
augroup END

" override defaults
nnoremap s <Nop>
