let mapleader=' '
let maplocalleader=';'

" move between open and close brackets
nnoremap <backspace> %
vnoremap <backspace> %
onoremap <backspace> %

" Folding
nnoremap <Leader><Leader> za

" Fast saving from all modes
nnoremap <Leader>w <Cmd>silent! w<CR>
nnoremap <Leader>nw <Cmd>noautocmd w<CR>
nnoremap <Leader>W <Cmd>noautocmd w<CR>
nmap <C-s> <space>w
xmap <C-s> <space>w
cmap <C-s> <space>w
nmap <C-S> <Cmd>let @+=expand("%:t")<CR>:saveas <C-r>+

" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>zz

" move between active splits
nnoremap <silent> <C-k> <Cmd>wincmd k<CR>
nnoremap <silent> <C-j> <Cmd>wincmd j<CR>
nnoremap <silent> <C-h> <Cmd>wincmd h<CR>
nnoremap <silent> <C-l> <Cmd>wincmd l<CR>
nnoremap <silent> <Tab> <C-w>w


" move between tabs
nnoremap <Leader>tl <Cmd>tabnext<CR>
nnoremap <Leader>th <Cmd>tabprev<CR>
nnoremap <Leader>tq <Cmd>tabclose<CR>
nnoremap <Leader>tn <Cmd>tabnew<CR>
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 <Cmd>tablast<CR>

" Yank
nnoremap <Leader>yb <Cmd>%y+<CR>
nnoremap <Leader>yfn <Cmd>let @+=expand("%:t")<CR>
  \ <Cmd>echo 'Yanked filename: <C-r>+'<CR>
nnoremap <Leader>yrp <Cmd>let @+=expand("%:~:.")<CR>
  \ <Cmd>echo 'Yanked relative path: <C-r>+'<CR>
nnoremap <Leader>yap <Cmd>let @+=expand("%:p")<CR>
  \ <Cmd>echo 'Yanked absolute path: <C-r>+'<CR>
nnoremap <Localleader>y "+y
vnoremap <Localleader>y "+y

" Paste
nnoremap <Leader>pa ggVGp
command! -range -nargs=1 VisualPaste call utils#visualPaste(<args>)
xnoremap p :VisualPaste 'p'<CR>
xnoremap P :VisualPaste 'P'<CR>
nnoremap <Localleader>P "+P
nnoremap <Localleader>p "+p
vnoremap <Localleader>p :VisualPaste '"+p'<CR>
nnoremap <Localleader>v "+p
vnoremap <Localleader>v :VisualPaste '"+p'<CR>
nnoremap <Localleader>V "+P
nnoremap <C-v> "+p
vnoremap <C-v> :VisualPaste '"+p'<CR>

" Jump to the beginning/end of a line
noremap <Leader>h ^
noremap H ^
nnoremap <Leader>l $
onoremap <Leader>l $
xnoremap <Leader>l $h
noremap L g_

" Terminal
noremap <Leader>zz <Cmd>terminal<CR>i
noremap <Leader>zj <Cmd>split<CR><Cmd>terminal<CR>13<C-w>_i
nmap <Leader>zl <Cmd>vsplit<CR> zz
command! ToggleTerminal call interface#ToggleTerminal()
nnoremap <Leader>` <Cmd>ToggleTerminal<CR>
" nnoremap <Leader>z4 :term<CR>:vs<CR>:term<CR>:sp<CR>:term<CR>:wincmd h<CR>:sp<CR>:term<CR>

" Preview markdown
" noremap <Leader>mp <Cmd>term glow %<CR>

" Discard all changes
noremap <Leader>q <Cmd>e!<CR>

" Open previous buffer
noremap <Leader>bb <C-^>

nnoremap <Leader>yaa ggyG''
nnoremap <Leader>ypG VGyGp

" Delete current file
nnoremap <Leader>rm <Cmd>silent! write<bar>call delete(expand('%'))<bar>b#<bar>bd#<CR>

" Close current buffer
nnoremap <Leader>bd <Cmd>b#<bar>bd#<CR>

" Git
nnoremap <Leader>gdh <Cmd>diffget //2<CR>
nnoremap <Leader>gdl <Cmd>diffget //3<CR>

" Find
nmap <Leader>fp /<C-r>0<CR>
nnoremap <Leader>fn <Cmd>Navbuddy<CR>
nmap * *N

" Edit file
nnoremap <Leader>ze <Cmd>e ~/.zshrc<CR>

" Center focused line
let line_moved_commands = ['u', 'e', '<C-r>', 'n', 'N', 'G', 'w', 'b', '``']
for cmd in line_moved_commands
  execute 'noremap <silent> '.cmd.' '.cmd.'zz'
  " execute 'vnoremap <silent> '.cmd.' '.cmd.'zz'
endfor

vmap <silent> j jzz
vmap <silent> k kzz
cmap <expr> <CR> getcmdtype() =~ '^[/?]$' ? '<CR>zz' : '<CR>'

nnoremap <Leader>zr <Cmd>res 13<CR>

" Print messages to buffer
nnoremap <Leader>mb <Cmd>put =execute('messages')<CR>
nmap <Leader>ml <Cmd>vs<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<CR> mb
nmap <Leader>mj <Cmd>sp<bar>execute 'edit'
  \ strftime('vim-messages-%Y-%m-%d.%H-%M-%S.log')<CR> mb

" text editing
nnoremap <CR> ciw
"   <C-H> maps to <C-Backspace>
inoremap <C-H> <C-w>
inoremap <C-v> <C-V>

" quit
nnoremap <Leader>cc <Cmd>cclose<CR>
augroup non_file_mapping
  autocmd!
  autocmd FileType lazy,help,NvimTree,checkhealth,Trouble,noice,fugitiveblame nnoremap <buffer> <Esc> <Cmd>q<CR>
  autocmd FileType lazy,help,NvimTree,checkhealth,Trouble,noice,fugitiveblame nmap <buffer> q <Esc>
  autocmd FileType lazy,help,NvimTree,checkhealth,Trouble,noice,fugitiveblame nmap <buffer> q <Esc>
  autocmd FileType qf nnoremap <buffer> <Esc> <Cmd>cclose<CR>
  autocmd FileType qf nnoremap <buffer> <CR> <Cmd>.cc<CR>
augroup END

" csv specific
augroup csv
  autocmd!
  autocmd FileType csv nnoremap <buffer> <Leader>ptt <Cmd>%s/\|/\t/g<CR>
  autocmd FileType csv nnoremap <buffer> <Leader>ttp <Cmd>%s/\t/\|/g<CR>
augroup END

" override defaults
nnoremap s <Nop>

" execute current file
map <F9> <Cmd>!%:p<CR>
