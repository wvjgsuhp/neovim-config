function! utils#startsWith(longer, shorter)
  return a:longer[0:len(a:shorter)-1] ==# a:shorter
endfunction

function! utils#isTerminal()
  return utils#startsWith(expand("%"), "term://")
endfunction

function! utils#visualPaste(direction) range abort
  try
    let registers = {}
    for name in ['"', '0']
      let registers[name] = {'type': getregtype(name), 'value': getreg(name)}
    endfor
    execute 'normal!' 'gv' . a:direction
  finally
    for [name, register] in items(registers)
      call setreg(name, register.value, register.type)
    endfor
  endtry
endfunction
