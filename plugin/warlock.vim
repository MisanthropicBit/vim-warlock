" vim: foldmethod=marker

" Source the vim-airline and lightline.vim theme files {{{
function! s:SetStatusLineThemes(path, colorscheme) abort
    if g:warlock#debug
        echom printf(
            \"Setting '%s' status line themes for '%s'",
            \a:colorscheme,
            \a:path,
        \)
    endif

    runtime
        \autoload/airline/themes/warlock.vim
        \autoload/lightline/themes/warlock.vim
endfunction
" }}}

if has('autocmd') && exists('##ColorScheme')
    augroup SetWarlockStatusLineThemes
        autocmd!
        autocmd ColorScheme warlock call s:SetStatusLineThemes(<afile>, <amatch>)
    augroup END
endif
