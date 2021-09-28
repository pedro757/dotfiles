augroup customHighlights
  au!
  " Gitsigns
  au ColorScheme * hi GitSignsChange guifg=#587c0c guibg=#3c3836
  au ColorScheme * hi GitSignsDelete guifg=#94151b guibg=#3c3836
  au ColorScheme * hi GitSignsAdd guifg=#0c7d9d guibg=#3c3836
  " LSP Saga
  au ColorScheme * hi LspSagaCodeActionTitle guifg=#587c0c guibg=#282828
  au ColorScheme * hi LspSagaCodeActionBorder guifg=#587c0c guibg=#282828
  au ColorScheme * hi LspSagaCodeActionTruncateLine guifg=#587c0c guibg=#282828
  au ColorScheme * hi LspSagaCodeActionContent guifg=#587c0c guibg=#282828

  au ColorScheme * hi StatusLine guifg=#3c3836
  au ColorScheme * hi MsgArea guifg=#bdae93
  au ColorScheme * hi ErrorMsg guifg=#fb4934 guibg=#282828
  au ColorScheme * hi Visual guifg=#3c3836 guibg=#ffff00
  au ColorScheme * hi TelescopeMatching guibg=#504945
  au ColorScheme * hi TelescopeSelection guifg=#d5cda1 guibg=#3c3836
  au ColorScheme * hi TelescopeNormal guifg=#d5cda1
  au ColorScheme * hi Search guifg=#3c3836 guibg=#ffff00

  au ColorScheme * hi LspDiagnosticsDefaultHint guifg=#928374 ctermfg=245
  au ColorScheme * hi LspDiagnosticsDefaultInfo guifg=#928374 ctermfg=245
  au ColorScheme * hi LspDiagnosticsDefaultError guifg=#d65d0e ctermfg=red
  au ColorScheme * hi LspDiagnosticsDefaultWarning guifg=#fabd2f ctermfg=yellow

  au ColorScheme * hi IndentBlanklineChar guifg=#343434 gui=nocombine
  au ColorScheme * hi IndentBlanklineContextChar guifg=#424242 gui=nocombine
augroup end
