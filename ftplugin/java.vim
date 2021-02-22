""" This is named java.vim to run with every java command.

function s:Javi_Init(...)
    " This function mostly exists to 'encapsulate' things.
    "
    if exists("g:javi_compiler") ==? 0
        let g:javi_compiler="javac"
    endif

    augroup javi
        autocmd!
    augroup END

    if exists("g:javi_compiler_java") ==? 0 || g:javi_compiler_java ==? 1
        call s:Javi_setcompiler()
        let g:javi_compiler_java = 1
    endif

    if exists("g:javi_classpath") ==? 0 || g:javi_classpath ==? 1
        call s:Javi_setclasspath()
        let g:javi_classpath = 1
    endif

    "This commands just calls the Down() and Init() functions to 'reload' the
    "plugin. This also disables any functionality that was disabled by the
    "user until reload.
    command! JaviReset call s:Javi_Down() | call s:Javi_Init()
endfunction

function s:Javi_Down(...)
    " This is just a cleanup and is to 'encapsulate' things a bit. It also
    " allows JaviReset to work.
    "
    let s:javi_classpath_set " We just do this incase the user disabled classpath detection
    unlet s:javi_classpath_set
    autocmd! javi 
    delcommand JaviReset
endfunction

function s:Javi_setcompiler(...)
    if exists("g:javi_compiler_java") ==? 0 || g:javi_compiler_java ==? 1
        exec "compiler "g:javi_compiler
    else
        " This is a bit of a \"hack" to disable this feature completely. If it
        " is disabled mid-session. The larger this becomes, the slower this
        " will be, and it will be best to remove it eventually.
        JaviReset
    endif
endfunction

function s:Javi_setclasspath(...)
    if exists("g:javi_classpath") ==? 0 || g:javi_classpath ==? 1
        if exists("$CLASSPATH") ==? 0 || exists("s:javi_classpath_set")
            let s:javi_classpath_set = 1
            let $CLASSPATH=expand('%:p:h')
        else
            if $CLASSPATH =~ '^\s*$'
                unlet $CLASSPATH
                call s:Javi_setclasspath()
            else
                let g:javi_classpath=0
            endif
        endif
    else
        " This is a bit of a \"hack" to disable this feature completely. If it
        " is disabled mid-session. The larger this becomes, the slower this
        " will be, and it will be best to remove it eventually.
        JaviReset
    endif
endfunction

call s:Javi_Init()
