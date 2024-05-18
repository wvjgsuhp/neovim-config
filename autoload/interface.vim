"function! interface#ToggleTerminal() abort
"  wincmd k
"  if utils#isTerminal()
"    return
"  endif
"
"  wincmd j
"  if utils#isTerminal()
"    quit
"    return
"  endif
"
"  split
"  resize 13
"
"  for buffer_ in getbufinfo({'buflisted': 1})
"    if utils#startsWith(buffer_.name, 'term://')
"      execute 'b ' . buffer_.name
"      startinsert
"      return
"    endif
"  endfor
"
"  term
"  startinsert
"endfunction

"TODO: multiple partial
function! interface#PartialLink(hl, link_hl, link_attributes, attributes = '') abort
  let l:hl_command = 'hi! ' . a:hl . ' ' . a:attributes
  for l:link_attr in a:link_attributes
    let l:mode = l:link_attr[:-3]
    let l:what = l:link_attr[-2:]
    let l:hl_command = l:hl_command . ' ' . l:link_attr . '='
      \. synIDattr(synIDtrans(hlID(a:link_hl)), l:what, l:mode)
  endfor

  exec l:hl_command
endfunction
