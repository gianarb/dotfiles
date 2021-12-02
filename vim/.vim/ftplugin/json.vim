setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal smarttab

" Format JSON with jq
function Fmt()
    if executable('jq')
        execute "%!jq '.'"
        execute "w"
    else
        echoerr "jq not found. It is require for this functionality."
    endif
endfunction
