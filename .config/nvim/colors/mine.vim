highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "mine"

if !(has('termguicolors') && &termguicolors) && !has('gui_running')
  finish
endif

let s:palette = {
  \ 'bg0':              ['#282828',   '235'],
  \ 'bg1':              ['#32302f',   '236'],
  \ 'bg2':              ['#32302f',   '236'],
  \ 'bg3':              ['#45403d',   '237'],
  \ 'bg4':              ['#45403d',   '237'],
  \ 'bg5':              ['#5a524c',   '239'],
  \ 'bg_statusline1':   ['#32302f',   '236'],
  \ 'bg_statusline2':   ['#3a3735',   '236'],
  \ 'bg_statusline3':   ['#504945',   '240'],
  \ 'bg_diff_green':    ['#34381b',   '22'],
  \ 'bg_visual_green':  ['#3b4439',   '22'],
  \ 'bg_diff_red':      ['#402120',   '52'],
  \ 'bg_visual_red':    ['#4c3432',   '52'],
  \ 'bg_diff_blue':     ['#0e363e',   '17'],
  \ 'fg_diff_text_blue':['#154c5e',   '240'],
  \ 'bg_visual_blue':   ['#374141',   '17'],
  \ 'bg_visual_yellow': ['#4f422e',   '94'],
  \ 'bg_current_word':  ['#3c3836',   '237'],
  \ 'fg0':              ['#d4be98',   '223'],
  \ 'fg1':              ['#ddc7a1',   '223'],
  \ 'red':              ['#ea6962',   '167'],
  \ 'orange':           ['#e78a4e',   '208'],
  \ 'yellow':           ['#d8a657',   '214'],
  \ 'green':            ['#a9b665',   '142'],
  \ 'aqua':             ['#89b482',   '108'],
  \ 'blue':             ['#7daea3',   '109'],
  \ 'purple':           ['#d3869b',   '175'],
  \ 'bg_red':           ['#ea6962',   '167'],
  \ 'bg_green':         ['#a9b665',   '142'],
  \ 'bg_yellow':        ['#d8a657',   '214'],
  \ 'grey0':            ['#7c6f64',   '243'],
  \ 'grey1':            ['#928374',   '245'],
  \ 'grey2':            ['#a89984',   '246'],
  \ 'none':             ['NONE',      'NONE']
  \ }

function! Colorize(group, fg, bg, ...)
  execute 'highlight' a:group
    \ 'guifg=' . a:fg[0]
    \ 'guibg=' . a:bg[0]
    \ 'ctermfg=' . a:fg[1]
    \ 'ctermbg=' . a:bg[1]
    \ 'gui=' . (a:0 >= 1 ?
      \ (a:1 ==# 'undercurl' ?
        \ 'undercurl' :
        \ a:1) :
      \ 'NONE')
    \ 'cterm=' . (a:0 >= 1 ?
      \ (a:1 ==# 'undercurl' ?
        \ 'underline' :
        \ a:1) :
      \ 'NONE')
    \ 'guisp=' . (a:0 >= 2 ?
      \ a:2[0] :
      \ 'NONE')
endfunction

call Colorize('Normal', s:palette.fg0, s:palette.bg0)
call Colorize('Terminal', s:palette.fg0, s:palette.bg0)
call Colorize('EndOfBuffer', s:palette.bg5, s:palette.bg0)
call Colorize('Folded', s:palette.grey1, s:palette.bg2)
call Colorize('ToolbarLine', s:palette.fg1, s:palette.bg3)
call Colorize('SignColumn', s:palette.fg0, s:palette.bg2)
call Colorize('FoldColumn', s:palette.grey1, s:palette.bg2)
call Colorize('IncSearch', s:palette.bg0, s:palette.bg_red)
call Colorize('Search', s:palette.bg0, s:palette.bg_green)
call Colorize('ColorColumn', s:palette.none, s:palette.bg2)
call Colorize('Conceal', s:palette.grey0, s:palette.none)
call Colorize('Cursor', s:palette.none, s:palette.none, 'reverse')
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
hi! link CursorIM Cursor

if &diff
  call Colorize('CursorLine', s:palette.none, s:palette.none, 'underline')
  call Colorize('CursorColumn', s:palette.none, s:palette.none, 'bold')
  call Colorize('CursorLineNr', s:palette.grey1, s:palette.none, 'underline')
  call Colorize('CurrentWord', s:palette.bg0, s:palette.bg_green)
else
  call Colorize('CursorLine', s:palette.none, s:palette.bg1)
  call Colorize('CursorColumn', s:palette.none, s:palette.bg1)
  call Colorize('CursorLineNr', s:palette.grey1, s:palette.bg1)
endif
call Colorize('LineNr', s:palette.grey0, s:palette.none)

call Colorize('DiffAdd', s:palette.none, s:palette.bg_diff_green)
call Colorize('DiffChange', s:palette.none, s:palette.bg_diff_blue)
call Colorize('DiffDelete', s:palette.none, s:palette.bg_diff_red)
call Colorize('DiffText', s:palette.none, s:palette.fg_diff_text_blue)
call Colorize('Directory', s:palette.green, s:palette.none)
call Colorize('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call Colorize('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call Colorize('ModeMsg', s:palette.fg0, s:palette.none, 'bold')
call Colorize('MoreMsg', s:palette.yellow, s:palette.none, 'bold')
call Colorize('MatchParen', s:palette.none, s:palette.bg4)
call Colorize('NonText', s:palette.bg5, s:palette.none)
call Colorize('Whitespace', s:palette.bg5, s:palette.none)
call Colorize('SpecialKey', s:palette.bg5, s:palette.none)
call Colorize('Pmenu', s:palette.fg1, s:palette.bg3)
call Colorize('PmenuSbar', s:palette.none, s:palette.bg3)
call Colorize('PmenuSel', s:palette.bg3, s:palette.grey2)
hi! link WildMenu PmenuSel
call Colorize('PmenuThumb', s:palette.none, s:palette.grey0)
call Colorize('NormalFloat', s:palette.fg1, s:palette.bg3)
call Colorize('Question', s:palette.yellow, s:palette.none)
call Colorize('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
call Colorize('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
call Colorize('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.aqua)
call Colorize('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
call Colorize('StatusLine', s:palette.fg1, s:palette.bg_statusline2)
call Colorize('StatusLineTerm', s:palette.fg1, s:palette.bg_statusline2)
call Colorize('StatusLineNC', s:palette.grey1, s:palette.bg_statusline2)
call Colorize('StatusLineTermNC', s:palette.grey1, s:palette.bg_statusline2)
call Colorize('TabLine', s:palette.fg1, s:palette.bg_statusline3)
call Colorize('TabLineFill', s:palette.fg1, s:palette.bg_statusline2)
call Colorize('TabLineSel', s:palette.bg0, s:palette.grey2)

call Colorize('VertSplit', s:palette.bg5, s:palette.none)
call Colorize('Visual', s:palette.none, s:palette.bg3)
call Colorize('VisualNOS', s:palette.none, s:palette.bg3)
call Colorize('QuickFixLine', s:palette.purple, s:palette.none, 'bold')
call Colorize('Debug', s:palette.orange, s:palette.none)
call Colorize('debugPC', s:palette.bg0, s:palette.green)
call Colorize('debugBreakpoint', s:palette.bg0, s:palette.red)
call Colorize('ToolbarButton', s:palette.bg0, s:palette.grey2)
call Colorize('Substitute', s:palette.bg0, s:palette.yellow)
hi! link DiagnosticFloatingError ErrorFloat
hi! link DiagnosticFloatingWarn WarningFloat
hi! link DiagnosticFloatingInfo InfoFloat
hi! link DiagnosticFloatingHint HintFloat
hi! link DiagnosticError ErrorText
hi! link DiagnosticWarn WarningText
hi! link DiagnosticInfo InfoText
hi! link DiagnosticHint HintText
hi! link DiagnosticVirtualTextError VirtualTextError
hi! link DiagnosticVirtualTextWarn VirtualTextWarning
hi! link DiagnosticVirtualTextInfo VirtualTextInfo
hi! link DiagnosticVirtualTextHint VirtualTextHint
hi! link DiagnosticUnderlineError ErrorText
hi! link DiagnosticUnderlineWarn WarningText
hi! link DiagnosticUnderlineInfo InfoText
hi! link DiagnosticUnderlineHint HintText
hi! link DiagnosticSignError RedSign
hi! link DiagnosticSignWarn YellowSign
hi! link DiagnosticSignInfo BlueSign
hi! link DiagnosticSignHint AquaSign
hi! link LspReferenceText CurrentWord
hi! link LspReferenceRead CurrentWord
hi! link LspReferenceWrite CurrentWord
hi! link TermCursor Cursor
hi! link healthError Red
hi! link healthSuccess Green
hi! link healthWarning Yellow

call Colorize('Boolean', s:palette.purple, s:palette.none)
call Colorize('Number', s:palette.purple, s:palette.none)
call Colorize('Float', s:palette.purple, s:palette.none)

call Colorize('PreProc', s:palette.purple, s:palette.none, 'italic')
call Colorize('PreCondit', s:palette.purple, s:palette.none, 'italic')
call Colorize('Include', s:palette.purple, s:palette.none, 'italic')
call Colorize('Define', s:palette.purple, s:palette.none, 'italic')
call Colorize('Conditional', s:palette.red, s:palette.none, 'italic')
call Colorize('Repeat', s:palette.red, s:palette.none, 'italic')
call Colorize('Keyword', s:palette.red, s:palette.none, 'italic')
call Colorize('Typedef', s:palette.red, s:palette.none, 'italic')
call Colorize('Exception', s:palette.red, s:palette.none, 'italic')
call Colorize('Statement', s:palette.red, s:palette.none, 'italic')

call Colorize('Error', s:palette.red, s:palette.none)
call Colorize('StorageClass', s:palette.orange, s:palette.none)
call Colorize('Tag', s:palette.orange, s:palette.none)
call Colorize('Label', s:palette.orange, s:palette.none)
call Colorize('Structure', s:palette.orange, s:palette.none)
call Colorize('Operator', s:palette.orange, s:palette.none)
call Colorize('Title', s:palette.orange, s:palette.none, 'bold')
call Colorize('Special', s:palette.yellow, s:palette.none)
call Colorize('SpecialChar', s:palette.yellow, s:palette.none)
call Colorize('Type', s:palette.yellow, s:palette.none)

call Colorize('Function', s:palette.green, s:palette.none, 'bold')

call Colorize('String', s:palette.green, s:palette.none)
call Colorize('Character', s:palette.green, s:palette.none)
call Colorize('Constant', s:palette.aqua, s:palette.none)
call Colorize('Macro', s:palette.aqua, s:palette.none)
call Colorize('Identifier', s:palette.blue, s:palette.none)

call Colorize('Comment', s:palette.grey1, s:palette.none, 'italic')
call Colorize('SpecialComment', s:palette.grey1, s:palette.none, 'italic')
call Colorize('Todo', s:palette.purple, s:palette.none, 'italic')

call Colorize('Delimiter', s:palette.fg0, s:palette.none)
call Colorize('Ignore', s:palette.grey1, s:palette.none)
call Colorize('Underlined', s:palette.none, s:palette.none, 'underline')

call Colorize('Fg', s:palette.fg0, s:palette.none)
call Colorize('Grey', s:palette.grey1, s:palette.none)
call Colorize('Red', s:palette.red, s:palette.none)
call Colorize('Orange', s:palette.orange, s:palette.none)
call Colorize('Yellow', s:palette.yellow, s:palette.none)
call Colorize('Green', s:palette.green, s:palette.none)
call Colorize('Aqua', s:palette.aqua, s:palette.none)
call Colorize('Blue', s:palette.blue, s:palette.none)
call Colorize('Purple', s:palette.purple, s:palette.none)

call Colorize('RedItalic', s:palette.red, s:palette.none, 'italic')
call Colorize('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
call Colorize('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
call Colorize('GreenItalic', s:palette.green, s:palette.none, 'italic')
call Colorize('AquaItalic', s:palette.aqua, s:palette.none, 'italic')
call Colorize('BlueItalic', s:palette.blue, s:palette.none, 'italic')
call Colorize('PurpleItalic', s:palette.purple, s:palette.none, 'italic')

call Colorize('RedBold', s:palette.red, s:palette.none, 'bold')
call Colorize('OrangeBold', s:palette.orange, s:palette.none, 'bold')
call Colorize('YellowBold', s:palette.yellow, s:palette.none, 'bold')
call Colorize('GreenBold', s:palette.green, s:palette.none, 'bold')
call Colorize('AquaBold', s:palette.aqua, s:palette.none, 'bold')
call Colorize('BlueBold', s:palette.blue, s:palette.none, 'bold')
call Colorize('PurpleBold', s:palette.purple, s:palette.none, 'bold')

call Colorize('RedSign', s:palette.red, s:palette.bg2)
call Colorize('OrangeSign', s:palette.orange, s:palette.bg2)
call Colorize('YellowSign', s:palette.yellow, s:palette.bg2)
call Colorize('GreenSign', s:palette.green, s:palette.bg2)
call Colorize('AquaSign', s:palette.aqua, s:palette.bg2)
call Colorize('BlueSign', s:palette.blue, s:palette.bg2)
call Colorize('PurpleSign', s:palette.purple, s:palette.bg2)

call Colorize('ErrorText', s:palette.none, s:palette.bg_visual_red, 'undercurl', s:palette.red)
call Colorize('WarningText', s:palette.none, s:palette.bg_visual_yellow, 'undercurl', s:palette.yellow)
call Colorize('InfoText', s:palette.none, s:palette.bg_visual_blue, 'undercurl', s:palette.blue)
call Colorize('HintText', s:palette.none, s:palette.bg_visual_green, 'undercurl', s:palette.green)

" call Colorize('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
" call Colorize('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
" call Colorize('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
" call Colorize('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)

call Colorize('ErrorLine', s:palette.none, s:palette.bg_visual_red)
call Colorize('WarningLine', s:palette.none, s:palette.bg_visual_yellow)
call Colorize('InfoLine', s:palette.none, s:palette.bg_visual_blue)
call Colorize('HintLine', s:palette.none, s:palette.bg_visual_green)

" hi clear ErrorLine
" hi clear WarningLine
" hi clear InfoLine
" hi clear HintLine

" hi! link VirtualTextWarning Grey
" hi! link VirtualTextError Grey
" hi! link VirtualTextInfo Grey
" hi! link VirtualTextHint Grey

hi! link VirtualTextWarning Yellow
hi! link VirtualTextError Red
hi! link VirtualTextInfo Blue
hi! link VirtualTextHint Green

call Colorize('ErrorFloat', s:palette.red, s:palette.bg3)
call Colorize('WarningFloat', s:palette.yellow, s:palette.bg3)
call Colorize('InfoFloat', s:palette.blue, s:palette.bg3)
call Colorize('HintFloat', s:palette.green, s:palette.bg3)

call Colorize('CurrentWord', s:palette.none, s:palette.bg_current_word)

let s:terminal = {
  \ 'black':         s:palette.bg5,
  \ 'red':           s:palette.red,
  \ 'yellow':        s:palette.yellow,
  \ 'green':         s:palette.green,
  \ 'cyan':          s:palette.aqua,
  \ 'blue':          s:palette.blue,
  \ 'purple':        s:palette.purple,
  \ 'white':         s:palette.fg0,
  \ }

let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
  \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
  \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]

" TS
call Colorize('TSStrong', s:palette.none, s:palette.none, 'bold')
call Colorize('TSEmphasis', s:palette.none, s:palette.none, 'bold')
call Colorize('TSUnderline', s:palette.none, s:palette.none, 'underline')
call Colorize('TSNote', s:palette.bg0, s:palette.blue, 'bold')
call Colorize('TSWarning', s:palette.bg0, s:palette.yellow, 'bold')
call Colorize('TSDanger', s:palette.bg0, s:palette.red, 'bold')
hi! link TSAnnotation Purple
hi! link TSAttribute Purple
hi! link TSBoolean Purple
hi! link TSCharacter Aqua
hi! link TSComment Comment
hi! link TSConditional Red
hi! link TSConstBuiltin BlueItalic
hi! link TSConstMacro BlueItalic
hi! link TSConstant Fg
hi! link TSConstructor GreenBold
hi! link TSException Red
hi! link TSField Green
hi! link TSFloat Purple
hi! link TSFuncBuiltin GreenBold
hi! link TSFuncMacro GreenBold
hi! link TSFunction GreenBold
hi! link TSInclude Red
hi! link TSKeyword Red
hi! link TSKeywordFunction Red
hi! link TSKeywordOperator Orange
hi! link TSLabel Orange
hi! link TSMethod GreenBold
hi! link TSNamespace YellowItalic
hi! link TSNone Fg
hi! link TSNumber Purple
hi! link TSOperator Orange
hi! link TSParameter Fg
hi! link TSParameterReference Fg
hi! link TSProperty Fg
hi! link TSPunctBracket Fg
hi! link TSPunctDelimiter Grey
hi! link TSPunctSpecial Blue
hi! link TSRepeat Red
hi! link TSString Aqua
hi! link TSStringEscape Green
hi! link TSStringRegex Green
hi! link TSStructure BlueItalic
hi! link TSSymbol Fg
hi! link TSTag Orange
hi! link TSTagDelimiter Green
hi! link TSText Green
hi! link TSStrike Grey
hi! link TSMath Blue
hi! link TSType Yellow
hi! link TSTypeBuiltin YellowItalic
hi! link TSURI markdownUrl
hi! link TSVariable Fg
hi! link TSVariableBuiltin BlueItalic


call Colorize('MatchParenCur', s:palette.none, s:palette.none, 'bold')
call Colorize('MatchWord', s:palette.none, s:palette.none, 'underline')
call Colorize('MatchWordCur', s:palette.none, s:palette.none, 'underline')

call Colorize('CmpItemAbbrMatch', s:palette.green, s:palette.none, 'bold')
call Colorize('CmpItemAbbrMatchFuzzy', s:palette.green, s:palette.none, 'bold')
hi! link CmpItemAbbr Fg
hi! link CmpItemAbbrDeprecated Fg
hi! link CmpItemMenu Fg
hi! link CmpItemKind Yellow
hi! link CmpItemKindText Fg
hi! link CmpItemKindMethod Green
hi! link CmpItemKindFunction Green
hi! link CmpItemKindConstructor Green
hi! link CmpItemKindField Green
hi! link CmpItemKindVariable Blue
hi! link CmpItemKindClass Yellow
hi! link CmpItemKindInterface Yellow
hi! link CmpItemKindModule Yellow
hi! link CmpItemKindProperty Blue
hi! link CmpItemKindUnit Purple
hi! link CmpItemKindValue Purple
hi! link CmpItemKindEnum Yellow
hi! link CmpItemKindKeyword Red
hi! link CmpItemKindSnippet Aqua
hi! link CmpItemKindColor Aqua
hi! link CmpItemKindFile Aqua
hi! link CmpItemKindReference Aqua
hi! link CmpItemKindFolder Aqua
hi! link CmpItemKindEnumMember Purple
hi! link CmpItemKindConstant Blue
hi! link CmpItemKindStruct Yellow
hi! link CmpItemKindEvent Orange
hi! link CmpItemKindOperator Orange
hi! link CmpItemKindTypeParameter Yellow

call Colorize('TelescopeMatching', s:palette.green, s:palette.none, 'bold')
hi! link TelescopeBorder Grey
hi! link TelescopePromptPrefix Orange
hi! link TelescopeSelection CursorLine

hi! GitSignsChange guifg=#0c7d9d guibg=#32302f
hi! GitSignsDelete guifg=#94151b guibg=#32302f
hi! GitSignsAdd guifg=#587c0c guibg=#32302f
hi! link GitSignsAddNr Green
hi! link GitSignsChangeNr Blue
hi! link GitSignsDeleteNr Red
hi! link GitSignsAddLn DiffAdd
hi! link GitSignsChangeLn DiffChange
hi! link GitSignsDeleteLn DiffDelete
hi! link GitSignsCurrentLineBlame Grey

call Colorize('IndentBlanklineContextChar', s:palette.bg5, s:palette.none)
call Colorize('IndentBlanklineChar', s:palette.bg4, s:palette.none)

hi! link diffAdded Green
hi! link diffRemoved Red
hi! link diffChanged Blue
hi! link diffOldFile Yellow
hi! link diffNewFile Orange
hi! link diffFile Aqua
hi! link diffLine Grey
hi! link diffIndexLine Purple

hi! link NvimTreeSymlink Fg
hi! link NvimTreeFolderName Green
hi! link NvimTreeRootFolder Grey
hi! link NvimTreeFolderIcon Orange
hi! link NvimTreeEmptyFolderName Green
hi! link NvimTreeOpenedFolderName Green
hi! link NvimTreeExecFile Fg
hi! link NvimTreeOpenedFile Fg
hi! link NvimTreeSpecialFile Fg
hi! link NvimTreeImageFile Fg
hi! link NvimTreeMarkdownFile Fg
hi! link NvimTreeIndentMarker Grey
hi! link NvimTreeGitDirty Yellow
hi! link NvimTreeGitStaged Blue
hi! link NvimTreeGitMerge Orange
hi! link NvimTreeGitRenamed Purple
hi! link NvimTreeGitNew Aqua
hi! link NvimTreeGitDeleted Red
hi! link NvimTreeLspDiagnosticsError RedSign
hi! link NvimTreeLspDiagnosticsWarning YellowSign
hi! link NvimTreeLspDiagnosticsInformation BlueSign
hi! link NvimTreeLspDiagnosticsHint GreenSign

call Colorize('helpNote', s:palette.purple, s:palette.none, 'bold')
call Colorize('helpHeadline', s:palette.red, s:palette.none, 'bold')
call Colorize('helpHeader', s:palette.orange, s:palette.none, 'bold')
call Colorize('helpURL', s:palette.green, s:palette.none, 'underline')
call Colorize('helpHyperTextEntry', s:palette.yellow, s:palette.none, 'bold')
hi! link helpHyperTextJump Yellow
hi! link helpCommand Aqua
hi! link helpExample Green
hi! link helpSpecial Blue
hi! link helpSectionDelim Grey

call Colorize('UltestPass', s:palette.green, s:palette.bg2)
call Colorize('UltestFail', s:palette.red, s:palette.bg2)
call Colorize('UltestRunning', s:palette.yellow, s:palette.bg2)

call Colorize('LspSagaCodeActionTitle', s:palette.green, s:palette.bg1)
call Colorize('LspSagaCodeActionBorder', s:palette.green, s:palette.bg1)
call Colorize('LspSagaCodeActionTruncateLine', s:palette.green, s:palette.bg1)
call Colorize('LspSagaCodeActionContent', s:palette.green, s:palette.bg1)

call Colorize('OperatorSandwichChange', s:palette.none, s:palette.fg_diff_text_blue)
call Colorize('OperatorSandwichDelete', s:palette.bg0, s:palette.bg_red)
call Colorize('OperatorSandwichAdd', s:palette.bg0, s:palette.bg_green)
