""" This is named java.vim to run with every java command.

function s:Javi_Init(...)
    if exists("g:javi_compiler") ==? 1
        g:javi_compiler="javac"
    endif

    augroup javi
        autocmd!
    augroup END

    if exists("g:javi_compiler_java") ==? 0 || g:javi_compiler_java ==? 1
        autocmd! javi FileType java compiler g:javi_compiler
        let g:javi_compiler_java = 1
    endif

    if exists("g:javi_classpath") ==? 0 || g:javi_classpath ==? 1
        autocmd! javi BufEnter,FileType java call s:Javi_setclasspath()
        let g:javi_classpath = 1
    endif
endfunction

function s:Javi_Down(...)
    autocmd! javi
    unlet s:javi_classpath_set
endfunction

function s:Javi_setcompiler(...)
    if exists("g:javi_compiler_java") ==? 0 || g:javi_compiler ==? 1
        compiler g:javi_compiler
    else
        " The following is just a 'hackish' way to uninstall this.
        call s:Javi_Down()
        call s:Javi_Init()
    endif
endfunction

function s:Javi_setclasspath(...)
    if exists("g:javi_classpath") ==? 0 || g:javi_classpath = 1
        if exists("$CLASSPATH") ==? 0 || exists("s:javi_classpath_set")
            let s:javi_classpath_set = 1
            let $CLASSPATH=expand('%:p:h')
        else
            if $CLASSPATH =~ '^\s*$'
                unlet $CLASSPATH
                call s:Javi_setclasspath
            else
                g:javi_classpath=0
            endif
        endif
    else
        " The following is just a 'hackish' way to uninstall this.
        call s:Javi_Down()
        call s:Javi_Init()
    endif
endfunction

call s:Javi_Init()
