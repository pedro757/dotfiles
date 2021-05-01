function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  end
  let &scrolloff = l:scrolloffsave
endfunction

" autocmd BufWritePre * %s/\s\+$//e
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

let g:my_qf_l = 0
let g:my_qf_g = 0

fun! ToggleQFList(global)
  if a:global
    if g:my_qf_g == 1
      let g:my_qf_g = 0
      cclose
    else
      let g:my_qf_g = 1
      copen
    end
  else
    if g:my_qf_l == 1
      let g:my_qf_l = 0
      lclose
    else
      let g:my_qf_l = 1
      lopen
    end
  endif
endfun
