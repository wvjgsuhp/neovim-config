" save sessions
fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
  if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
      for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
          exec 'sbuffer ' . l
        endif
      endfor
    endif
  endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" highlight on yank
autocmd TextYankPost *
  \ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}

" rounded border for popup menu
" call wilder#set_option(
"   \ 'renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
"     \ 'highlights': {
"     \   'border': 'Normal',
"     \ },
"     \ 'border': 'single',
"     \ })))
