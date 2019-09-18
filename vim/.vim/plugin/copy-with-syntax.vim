function CpSyntax()
    call tohtml#Convert2HTML(line('w0'), line('w$'))
    save! /tmp/ciao2.html
    execute "!xdg-open /tmp/ciao2.html"
endfunction
