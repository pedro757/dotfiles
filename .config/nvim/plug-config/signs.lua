-- " Git Signs
-- let g:signify_sign_change = '~'

require('gitsigns').setup({
  signs = {
    -- TODO add hl to colorscheme
    add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '契', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '契', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})

vim.api.nvim_exec([[
  augroup GitSignsHighlights
    au ColorScheme * hi GitSignsChange guifg=#587c0c guibg=#3c3836
    au ColorScheme * hi GitSignsDelete guifg=#94151b guibg=#3c3836
    au ColorScheme * hi GitSignsAdd guifg=#0c7d9d guibg=#3c3836
    au ColorScheme * hi LspSagaCodeActionTitle guifg=#587c0c guibg=#282828
    au ColorScheme * hi LspSagaCodeActionBorder guifg=#587c0c guibg=#282828
    au ColorScheme * hi LspSagaCodeActionTruncateLine guifg=#587c0c guibg=#282828
    au ColorScheme * hi LspSagaCodeActionContent guifg=#587c0c guibg=#282828
  augroup end
]], false)
