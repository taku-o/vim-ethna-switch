" ethna-switch.vim:
" Load Once:
if &cp || exists("g:loaded_ethna_switch")
    finish
endif
let g:loaded_ethna_switch = 1
let s:keepcpo = &cpo
set cpo&vim
" ---------------------------------------------------------------------

function! s:IsETAction()
    if (matchstr(expand('%:p'), '/act/\(.\{-\}/\)\{-\}.\{-\}\.php5\?$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:IsETView()
    if (matchstr(expand('%:p'), '/view/\(.\{-\}/\)\{-\}.\{-\}\.php5\?$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:IsETTemplate()
    if (matchstr(expand('%:p'), '/tpl/\(.\{-\}/\)\{-\}.\{-\}\.tpl$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:GetETActionPathFromView()
    let root  = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = root. '/act/'. dir. fname
    return a
endfunction

function! s:GetETActionPathFromTemplate()
    let root  = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\4', '')

    let a = root. '/act/'. substitute(substitute(dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g'). substitute(fname, '\(\zs\)\(.*\)\(.tpl\)', '\u\1\2.php', '')
    return a
endfunction

function! s:GetETViewPathFromAction()
    let root  = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = root. '/view/'. dir. fname
    return a
endfunction

function! s:GetETViewPathFromTemplate()
    let root  = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\4', '')

    let a = root. '/view/'. substitute(substitute(dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g'). substitute(fname, '\(\zs\)\(.*\)\(.tpl\)', '\u\1\2.php', '')
    return a
endfunction

function! s:GetETTemplatePathFromAction()
    let root  = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = root. '/tpl/'. tolower(dir). substitute(tolower(fname), '.php5\?', '.tpl', '')
    return a
endfunction

function! s:GetETTemplatePathFromView()
    let root  = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let dir   = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let fname = substitute(expand('%:p'), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = root. '/tpl/'. tolower(dir). substitute(tolower(fname), '.php5\?', '.tpl', '')
    return a
endfunction

function! s:ETAction()
    if s:IsETAction()
        return
    elseif s:IsETView()
        execute ':e '. s:GetETActionPathFromView()
    elseif s:IsETTemplate()
        execute ':e '. s:GetETActionPathFromTemplate()
    else
        return
    endif
endfunction

function! s:ETView()
    if s:IsETAction()
        execute ':e '. s:GetETViewPathFromAction()
    elseif s:IsETView()
        return
    elseif s:IsETTemplate()
        execute ':e '. s:GetETViewPathFromTemplate()
    else
        return
    endif
endfunction

function! s:ETTemplate()
    if s:IsETAction()
        execute ':e '. s:GetETTemplatePathFromAction()
    elseif s:IsETView()
        execute ':e '. s:GetETTemplatePathFromView()
    elseif s:IsETTemplate()
        return
    else
        return
    endif
endfunction

command! -nargs=0 ETAction   call s:ETAction()
command! -nargs=0 ETView     call s:ETView()
command! -nargs=0 ETTemplate call s:ETTemplate()

" ---------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo

