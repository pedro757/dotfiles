augroup StopNewlineComments
  autocmd!
  au BufEnter * set formatoptions-=cro
augroup END

augroup TrimSpaces
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END

augroup OnlyOneCursorLine
  autocmd!
  autocmd WinEnter,InsertLeave * set cursorline
  autocmd WinLeave,InsertEnter * set nocursorline
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 140})
augroup END

augroup luaSources
  autocmd!
  autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lua' },
\     { name = 'buffer' },
\     { name = 'path' },
\     { name = 'luasnip' },
\     { name = 'rg' }
\   },
\ }
augroup END

augroup AutoCompile
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END

augroup Targets
  autocmd!
  autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'b': {'pair': [{'o':'(', 'c':')'}]}
    \ })
augroup END

command Worktree lua require("telescope").extensions.git_worktree.git_worktrees()
command WW SudaWrite
