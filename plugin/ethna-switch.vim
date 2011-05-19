" ethna-switch.vim:
" Load Once:
if &cp || exists("g:loaded_ethna_switch")
    finish
endif
let g:loaded_ethna_switch = 1
let s:keepcpo = &cpo
set cpo&vim
" ---------------------------------------------------------------------

function! s:FullPath()
    return expand('%:p')
endfunction

function! s:IsETAction()
    if (matchstr(s:FullPath(), '/act/\(.\{-\}/\)\{-\}.\{-\}\.php5\?$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:IsETView()
    if (matchstr(s:FullPath(), '/view/\(.\{-\}/\)\{-\}.\{-\}\.php5\?$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:IsETTemplate()
    if (matchstr(s:FullPath(), '/tpl/\(.\{-\}/\)\{-\}.\{-\}\.tpl$') != '')
        return 1
    else
        return 0
    endif
endfunction

function! s:GetETActionPathFromView()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = l:root. '/act/'. l:dir. l:fname
    return a
endfunction

function! s:GetETActionPathFromTemplate()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\4', '')

    let a = l:root. '/act/'. substitute(substitute(l:dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g'). substitute(l:fname, '\(\zs\)\(.*\)\(.tpl\)', '\u\1\2.php', '')
    return a
endfunction

function! s:GetETViewPathFromAction()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = l:root. '/view/'. l:dir. l:fname
    return a
endfunction

function! s:GetETViewPathFromTemplate()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\4', '')

    let a = l:root. '/view/'. substitute(substitute(l:dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g'). substitute(l:fname, '\(\zs\)\(.*\)\(.tpl\)', '\u\1\2.php', '')
    return a
endfunction

function! s:GetETTemplatePathFromAction()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = l:root. '/tpl/'. tolower(l:dir). substitute(tolower(l:fname), '.php5\?', '.tpl', '')
    return a
endfunction

function! s:GetETTemplatePathFromView()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')
    let l:fname = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\4', '')

    let a = l:root. '/tpl/'. tolower(l:dir). substitute(tolower(l:fname), '.php5\?', '.tpl', '')
    return a
endfunction

function! s:GetETActionDirFromAction()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/act/'. l:dir
    return a
endfunction

function! s:GetETActionDirFromView()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/act/'. l:dir
    return a
endfunction

function! s:GetETActionDirFromTemplate()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')

    let a = l:root. '/act/'. substitute(substitute(l:dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g')
    return a
endfunction

function! s:GetETViewDirFromAction()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/view/'. l:dir
    return a
endfunction

function! s:GetETViewDirFromView()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/view/'. l:dir
    return a
endfunction

function! s:GetETViewDirFromTemplate()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')

    let a = l:root. '/view/'. substitute(substitute(l:dir, '.*', '\u\0', ''), '/\(.\)', '/\u\1', 'g')
    return a
endfunction

function! s:GetETTemplateDirFromAction()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/act/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/tpl/'. tolower(l:dir)
    return a
endfunction

function! s:GetETTemplateDirFromView()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/view/\(\(.\{-\}/\)*\)\(.\{-\}\.php5\?\)$', '\2', '')

    let a = l:root. '/tpl/'. tolower(l:dir)
    return a
endfunction

function! s:GetETTemplateDirFromTemplate()
    let l:root  = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\1', '')
    let l:dir   = substitute(s:FullPath(), '^\(.*\)/tpl/\(\(.\{-\}/\)*\)\(.\{-\}\.tpl\)$', '\2', '')

    let a = l:root. '/tpl/'. tolower(l:dir)
    return a
endfunction

function! s:GetPHPFileName(path)
    if filereadable(a:path. '5')
        return a:path. '5'
    else
        return a:path
    endif
endfunction

function! s:IsDirectory(path)
    let l:path = substitute(a:path, '/$', '', '')
    if isdirectory(l:path)
        return 1
    else
        return 0
    endif
endfunction

function! s:ETAction()
    if s:IsETAction()
        return
    elseif s:IsETView()
        if s:IsDirectory(s:GetETActionDirFromView())
            execute ':e '. s:GetPHPFileName(s:GetETActionPathFromView())
        else
            echohl WarningMsg | echo 'directory '. s:GetETActionDirFromView(). ' is not found.' | echohl None
        endif
    elseif s:IsETTemplate()
        if s:IsDirectory(s:GetETActionDirFromTemplate())
            execute ':e '. s:GetPHPFileName(s:GetETActionPathFromTemplate())
        else
            echohl WarningMsg | echo 'directory '. s:GetETActionDirFromTemplate(). ' is not found.' | echohl None
        endif
    else
        return
    endif
endfunction

function! s:ETView()
    if s:IsETAction()
        if s:IsDirectory(s:GetETViewDirFromAction())
            execute ':e '. s:GetPHPFileName(s:GetETViewPathFromAction())
        else
            echohl WarningMsg | echo 'directory '. s:GetETViewDirFromAction(). ' is not found.' | echohl None
        endif
    elseif s:IsETView()
        return
    elseif s:IsETTemplate()
        if s:IsDirectory(s:GetETViewDirFromTemplate())
            execute ':e '. s:GetPHPFileName(s:GetETViewPathFromTemplate())
        else
            echohl WarningMsg | echo 'directory '. s:GetETViewDirFromTemplate(). ' is not found.' | echohl None
        endif
    else
        return
    endif
endfunction

function! s:ETTemplate()
    if s:IsETAction()
        if s:IsDirectory(s:GetETTemplateDirFromAction())
            execute ':e '. s:GetETTemplatePathFromAction()
        else
            echohl WarningMsg | echo 'directory '. s:GetETTemplateDirFromAction(). ' is not found.' | echohl None
        endif
    elseif s:IsETView()
        if s:IsDirectory(s:GetETTemplateDirFromView())
            execute ':e '. s:GetETTemplatePathFromView()
        else
            echohl WarningMsg | echo 'directory '. s:GetETTemplateDirFromView(). ' is not found.' | echohl None
        endif
    elseif s:IsETTemplate()
        return
    else
        return
    endif
endfunction

function! s:ReplacedCmd(path)
    let l:loc = strpart(getcmdline(), 0, getcmdpos() - 1)
    let l:roc = strpart(getcmdline(), getcmdpos() - 1)
    call setcmdpos(strlen(l:loc) + strlen(a:path) + 1)
    return l:loc. a:path. l:roc
endfunction

function! s:InsertETActionDir()
    if s:IsETAction()
        return s:ReplacedCmd(s:GetETActionDirFromAction())
    elseif s:IsETView()
        return s:ReplacedCmd(s:GetETActionDirFromView())
    elseif s:IsETTemplate()
        return s:ReplacedCmd(s:GetETActionDirFromTemplate())
    else
        return getcmdline()
    endif
endfunction

function! s:InsertETViewDir()
    if s:IsETAction()
        return s:ReplacedCmd(s:GetETViewDirFromAction())
    elseif s:IsETView()
        return s:ReplacedCmd(s:GetETViewDirFromView())
    elseif s:IsETTemplate()
        return s:ReplacedCmd(s:GetETViewDirFromTemplate())
    else
        return getcmdline()
    endif
endfunction

function! s:InsertETTemplateDir()
    if s:IsETAction()
        return s:ReplacedCmd(s:GetETTemplateDirFromAction())
    elseif s:IsETView()
        return s:ReplacedCmd(s:GetETTemplateDirFromView())
    elseif s:IsETTemplate()
        return s:ReplacedCmd(s:GetETTemplateDirFromTemplate())
    else
        return getcmdline()
    endif
endfunction

command! -nargs=0 ETAction   call <SID>ETAction()
command! -nargs=0 ETView     call <SID>ETView()
command! -nargs=0 ETTemplate call <SID>ETTemplate()

cmap <C-X><C-A> <C-\>e<SID>InsertETActionDir()<CR>
cmap <C-X><C-V> <C-\>e<SID>InsertETViewDir()<CR>
cmap <C-X><C-T> <C-\>e<SID>InsertETTemplateDir()<CR>

" ---------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo

