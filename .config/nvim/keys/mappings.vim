" move to text buffer
nnoremap <F3> :bnext<CR>
nnoremap <F2> :bprevious<CR>
nnoremap <F4> :bd<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Move line
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
nnoremap <silent> <A-down> :m .+1<CR>==
nnoremap <silent> <A-up> :m .-2<CR>==
inoremap <silent> <A-down> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-up> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-down> :m '>+1<CR>gv=gv
vnoremap <silent> <A-up> :m '<-2<CR>gv=gv

" Ranger
nmap <silent> <space>r :RnvimrToggle<CR>

" New Line Pressing Enter
nmap <silent><S-Enter> :call AddEmptyLineAbove()<CR>
nmap <silent><CR> :call AddEmptyLineBelow()<CR>

cnoremap <C-A> <Home>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-l> <CR>

" Vim defaults
nnoremap Y y$
inoremap <C-c> <Esc>
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>c :<BS>

" Telescope
nnoremap <leader>f <cmd>Telescope find_files find_command=fd,-I,--type,f,--hidden,-E,.git,-E,node_modules,-E,**/cache,-E,plugged previewer=false<cr>
nnoremap <leader>g <cmd>lua require'telescope.builtin'.git_files({previewer = false})<CR>
" nnoremap <leader>gr <cmd>lua require'telescope.builtin'.lsp_references()<CR><c-c>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr><c-c>
" nnoremap <leader>a <cmd>lua require'telescope.builtin'.lsp_range_code_actions()<CR><c-c>

" Snippets And Completion
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : "\<TAB>"
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : "\<TAB>"
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     pumvisible() ?  compe#close('<C-e>') :  "\<C-e>"
inoremap <silent><expr> <C-f>     pumvisible() ? compe#scroll({ 'delta': +4 })  :  "\<C-f>"
inoremap <silent><expr> <C-d>     pumvisible() ? compe#scroll({ 'delta': -4 })  :  "\<C-d>"

" QuickFixList
nnoremap <silent> <C-q> :call ToggleQFList(0)<CR>
nnoremap <silent> <leader>q :call ToggleQFList(1)<CR>

map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" Git
nnoremap <leader>hn <cmd>lua require"gitsigns".next_hunk()<CR>
nnoremap <leader>hN <cmd>lua require"gitsigns".prev_hunk()<CR>

" LSP
nnoremap <silent> gD         <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd         <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh         <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>i  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>D  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>d  <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>dN <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>dq <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>=  <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>a  <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> <leader>a  <cmd><C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
