" Vim color file -- with 256 colour support!
"
" Author: Anthony Carapetis <anthony.carapetis@gmail.com>
" Contributors: Lucas Tadeu <lucastadeuteixeira@gmail.com>
"
" Note: Based on github's syntax highlighting theme
"       Used Brian Mock's darkspectrum as a starting point/template
"       Thanks to Ryan Heath for an easy list of some of the colours:
"       http://rpheath.com/posts/356-github-theme-for-syntax-gem

set background=light

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let colors_name = "github"

hi Normal       ctermfg=0     ctermbg=255   guifg=#000000 guibg=#f6f8fa
hi Cursor       ctermfg=0     ctermbg=14    guifg=#f6f8fa guibg=#00F8F8
hi Visual       ctermbg=252   guibg=#d4d4d4
hi VisualNOS    ctermfg=15    ctermbg=24    guifg=#FFFFFF guibg=#204a87
hi Search       ctermfg=236   ctermbg=228   guifg=#000000 guibg=#FFFF8C cterm=bold  gui=bold
hi Folded       ctermfg=8     ctermbg=15    guifg=#808080 guibg=#ECECEC gui=bold    cterm=bold
hi Title        ctermfg=167   guifg=#ef5939
hi StatusLine   ctermfg=238   ctermbg=250   guifg=#404040 guibg=#bbbbbb gui=bold    cterm=bold
hi StatusLineNC ctermfg=238   ctermbg=252   guifg=#404040 guibg=#d4d4d4 gui=italic  cterm=italic
hi SpecialKey   ctermfg=6     guifg=#177F80 gui=italic    cterm=italic
hi WarningMsg   ctermfg=167   guifg=#ef5939
hi ErrorMsg     ctermbg=15    ctermfg=196   guibg=#f8f8ff guifg=#ff1100 gui=undercurl cterm=undercurl
hi ColorColumn  ctermbg=254   guibg=#e4e4e4
hi SignColumn   ctermbg=none  guibg=none
call interface#PartialLink("VertSplit", "Normal", ["guibg", 'ctermbg'], "ctermfg=250 guifg=#bbbbbb")
call interface#PartialLink("LineNr", "Normal", ["guibg", 'ctermbg'], "ctermfg=246 guifg=#959595")
hi EndOfBuffer  ctermfg=255   guifg=#f6f8fa

hi CursorLine     ctermbg=253 guibg=#ECECEC
hi MatchParen     ctermfg=0   ctermbg=252 guifg=#000000 guibg=#cdcdfd
hi Pmenu          ctermfg=0   ctermbg=254 guifg=#000000 guibg=#eaeef2
hi PmenuSel       ctermfg=15  ctermbg=61  guifg=#FFFFFF guibg=#3465a3
hi PmenuSbar      ctermfg=246 ctermbg=15  guifg=#959595 guibg=#ECECEC
hi PmenuThumb     ctermfg=250 ctermbg=250 guifg=#bbbbbb guibg=#bbbbbb
hi PmenuBorder    ctermfg=254 ctermbg=254 guibg=#eaeef2 guifg=#eaeef2
hi PmenuPadding   ctermfg=254 ctermbg=254 guibg=#f6f8fa guifg=#eaeef2
hi PmenuTitle     ctermfg=0   ctermbg=254 guifg=#000000 guibg=#eaeef2 gui=bold  cterm=bold
hi PmenuSeparator ctermfg=252 ctermbg=254 guibg=#eaeef2 guifg=#d4d4d4
hi PmenuEnd       ctermfg=254 ctermbg=254 guibg=#eaeef2 guifg=#eaeef2

hi DiffAdd    ctermfg=233 ctermbg=194   guifg=#003300 guibg=#DDFFDD gui=none  cterm=none
hi DiffChange ctermbg=255 guibg=#ececec gui=none      cterm=none
hi DiffText   ctermfg=233 ctermbg=189   guifg=#000033 guibg=#DDDDFF gui=none  cterm=none
hi DiffDelete ctermfg=252 ctermbg=224   guifg=#DDCCCC guibg=#FFDDDD gui=none  cterm=none

hi Ignore       ctermfg=8   guifg=#808080
" hi Identifier   ctermfg=31  guifg=#204a87
hi Identifier   ctermfg=31  guifg=#0086B3
hi PreProc      ctermfg=247 guifg=#A0A0A0 gui=bold      cterm=bold
hi Comment      ctermfg=246 guifg=#999988
hi Constant     ctermfg=6   guifg=#177F80 gui=none      cterm=none
hi String       ctermfg=161 guifg=#D81745
hi Function     ctermfg=88  guifg=#990000 gui=bold      cterm=bold
hi Statement    ctermfg=0   guifg=#000000 gui=bold      cterm=bold
hi Type         ctermfg=60  guifg=#445588 gui=bold      cterm=bold
hi Number       ctermfg=30  guifg=#1C9898
hi Todo         ctermfg=15  ctermbg=88    guifg=#FFFFFF guibg=#990000 gui=bold      cterm=bold
hi Special      ctermfg=28  guifg=#159828 gui=bold      cterm=bold
hi Label        ctermfg=0   guifg=#000000 gui=bold      cterm=bold
hi StorageClass ctermfg=0   guifg=#000000 gui=bold      cterm=bold
hi Structure    ctermfg=0   guifg=#000000 gui=bold      cterm=bold
hi TypeDef      ctermfg=0   guifg=#000000 gui=bold      cterm=bold

" treesitter
call interface#PartialLink("@operator", "Normal", ["guifg", 'ctermfg'])
call interface#PartialLink("@punctuation.delimiter", "Special", ["guifg", 'ctermfg'])
hi link @punctuation.bracket @punctuation.delimiter

hi LspReferenceText ctermbg=252 guibg=#d0d7de
hi link LspReferenceRead   LspReferenceText
hi link LspReferenceWrite  LspReferenceText

" gitsigns
hi GitSignsAdd    guifg=#A0D3C1
hi GitSignsDelete guifg=#E5886A
hi GitSignsChange guifg=#cdcdfd

" nvim-navic
" hi NavicIconsFile
hi link NavicIconsModule      Label
hi link NavicIconsNamespace   Identifier
hi link NavicIconsPackage     Label
hi link NavicIconsClass       Type
hi link NavicIconsMethod      Function
hi link NavicIconsProperty    Identifier
hi link NavicIconsField       Identifier
hi link NavicIconsConstructor Special
hi link NavicIconsEnum        Statement
hi link NavicIconsInterface   Statement
hi link NavicIconsFunction    Function
hi link NavicIconsVariable    Identifier
hi link NavicIconsConstant    Constant
hi link NavicIconsString      String
hi link NavicIconsNumber      Number
hi link NavicIconsArray       Identifier
hi link NavicIconsObject      Identifier
" hi NavicIconsKey
" hi NavicIconsNull
" hi NavicIconsEnumMember
hi link NavicIconsStruct      Type
" hi NavicIconsEvent
" hi NavicIconsOperator
" hi link NavicIconsTypeParameter Type
" hi NavicText
call interface#PartialLink("NavicIconsBoolean", "Normal", ["guifg"])
call interface#PartialLink("NavicSeparator", "VertSplit", ["guifg"])

hi! link FoldColumn   Folded
hi! link CursorColumn CursorLine
hi! link NonText      LineNr

hi link cppSTL          Function
hi link cppSTLType      Type
hi link Character       Number
hi link htmlTag         htmlEndTag
hi link htmlLink        Underlined
hi link pythonFunction  Identifier
hi link Question        Type
hi link CursorIM        Cursor
hi link VisualNOS       Visual
hi link xmlTag          Identifier
hi link xmlTagName      Identifier
hi link shDeref         Identifier
hi link shVariable      Function
hi link rubySharpBang   Special
hi link perlSharpBang   Special
hi link schemeFunc      Statement

hi TabLine      ctermfg=238 ctermbg=188   guifg=#404040 guibg=#dddddd gui=none
hi TabLineSel   ctermfg=238 guifg=#404040 gui=bold
hi link TabLineFill TabLine

if has("spell")
  hi spellBad     guisp=#fcaf3e
  hi spellCap     guisp=#73d216
  hi spellRare    guisp=#fcaf3e
  hi spellLocal   guisp=#729fcf
endif

hi DiagnosticError  ctermfg=1   guifg=#ff0000
hi DiagnosticWarn   ctermfg=209 guifg=#FF895C
hi DiagnosticInfo   ctermfg=245 guifg=#888888
hi DiagnosticHint   ctermfg=111 guifg=#87d7ff
hi DiagnosticOk     ctermfg=2   guifg=#159828

hi StatusLineN1       ctermfg=188   ctermbg=0   guifg=#dddddd guibg=#000000 gui=none cterm=none
hi StatusLineN2       ctermfg=188   ctermbg=238 guifg=#dddddd guibg=#404040 gui=none cterm=none
hi StatusLineN3       ctermfg=0     ctermbg=188 guifg=#000000 guibg=#dddddd gui=none cterm=none
hi StatusLineI1       ctermfg=188   ctermbg=26  guifg=#dddddd guibg=#005cc5 gui=none cterm=none
hi StatusLineI2       ctermfg=188   ctermbg=17  guifg=#dddddd guibg=#032f62 gui=none cterm=none
hi StatusLineV1       ctermfg=188   ctermbg=91  guifg=#dddddd guibg=#6f42c1 gui=none cterm=none
hi StatusLineV2       ctermfg=188   ctermbg=237 guifg=#dddddd guibg=#45267d gui=none cterm=none
hi StatusLineR1       ctermfg=188   ctermbg=167 guifg=#dddddd guibg=#d73a49 gui=none cterm=none
hi StatusLineR2       ctermfg=188   ctermbg=124 guifg=#dddddd guibg=#b31d28 gui=none cterm=none
hi StatusLineRO       ctermfg=167   ctermbg=188 guifg=#ff0000 guibg=#dddddd gui=none cterm=none
hi StatusLineInactive guifg=#404040 guibg=#d4d4d4

let s:win_bar_glyph_hl = {
  \"StatusLineError":       "guifg=#ff0000",
  \"StatusLineInfo":        "guifg=#87d7ff",
  \"StatusLineHint":        "guifg=#888888",
  \"StatusLineWarn":        "guifg=#FF895C",
  \"StatusLineChanges":     "guifg=#6f42c1",
  \"StatusLineGitAdded":    "guifg=#159828",
  \"StatusLineGitRemoved":  "guifg=#ef5939",
  \"StatusLineGitChanged":  "guifg=#6f42c1"
\}
for [hl, attributes] in items(s:win_bar_glyph_hl)
  call interface#PartialLink(hl, "StatusLineN3", ["guibg"], attributes)
endfor

hi WinBar           guifg=#888888 gui=none
hi WinBarNC         guifg=#d4d4d4 gui=none
hi WinBarLocation   guifg=#888888 gui=none
hi WinBarModified   guifg=#d7d787 gui=none
hi WinBarGitDirty   guifg=#d7afd7 gui=none
hi WinBarIndicator  guifg=#5fafd7 gui=none
hi WinBarIcon       guifg=#404040 gui=none
hi WinBarIconDarker guifg=#404040 guibg=#eaeef2 gui=none

" hi link NormalFloat Normal
hi link FloatBorder Normal
hi link NormalFloat Pmenu
" hi link FloatBorder PmenuBorder

hi link NoiceCmdlinePopupBorder PmenuPadding
hi link NoiceCmdlinePopup       Normal
hi link NoiceCmdlineIcon        Normal
hi link NoicePopup              Pmenu
hi link NoicePopupBorder        PmenuPadding
hi link NoiceSplit              Pmenu
hi link NoiceConfirm            Pmenu

hi link NotifyBackground Pmenu
hi link NotifyERRORBody Pmenu
hi link NotifyWARNBody Pmenu
hi link NotifyINFOBody Pmenu
hi link NotifyDEBUGBody Pmenu
hi link NotifyTRACEBody Pmenu
" hi link NotifyERRORBorder DiagnosticError
" hi link NotifyWARNBorder  DiagnosticWarn
" hi link NotifyINFOBorder  DiagnosticInfo
" hi link NotifyDEBUGBorder DiagnosticHint
hi link NotifyERRORIcon   DiagnosticError
hi link NotifyWARNIcon    DiagnosticWarn
hi link NotifyINFOIcon    DiagnosticInfo
hi link NotifyDEBUGIcon   DiagnosticHint
hi link NotifyERRORTitle  DiagnosticError
hi link NotifyWARNTitle   DiagnosticWarn
hi link NotifyINFOTitle   DiagnosticInfo
hi link NotifyDEBUGTitle  DiagnosticHint

call interface#PartialLink('TelescopeNormal', "Normal", ['guifg'], 'guibg=#eaeef2')
hi link TelescopePromptNormal Normal
hi link TelescopeTitle        PmenuTitle
hi link TelescopeBorder       PmenuSeparator

" call interface#PartialLink('WilderNormal', "Normal", ['guifg'], 'guibg=#eaeef2')
" hi WilderBorder  guibg=#eaeef2 guifg=#eaeef2
" hi WilderPrompt  ctermfg=0     ctermbg=255   guifg=#000000 guibg=#f6f8fa

hi link LazyNormal Pmenu

call interface#PartialLink('CmpItemAbbrDeprecated', "Ignore", ['guifg'], 'gui=strikethrough')
hi CmpItemAbbrMatch guibg=NONE guifg=#0086B3
hi link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
hi link CmpItemKindVariable   Identifier
hi link CmpItemKindInterface  CmpItemKindVariable
hi link CmpItemKindText       CmpItemKindVariable
hi link CmpItemKindFunction   Function
hi link CmpItemKindMethod     CmpItemKindFunction
hi link CmpItemKindKeyword    Statement
hi link CmpItemKindProperty   CmpItemKindKeyword
hi link CmpItemKindUnit       CmpItemKindKeyword

hi link NvimTreeNormal      Pmenu
hi link NvimTreeNormalFloat Pmenu
hi link NvimTreeLineNr      Pmenu
hi link NvimTreeCursorLine  PmenuSel
hi link NvimTreeEndOfBuffer PmenuBorder

" hi link NavbuddyNormalFloat Pmenu
" hi link NavbuddyFloatBorder PmenuSeparator
" hi link EndOfBuffer         PmenuBorder

hi link WhichKeyFloat Pmenu

hi link DashboardHeader Ignore
hi link DashboardFooter Constant

hi link MasonNormal Pmenu
hi link MasonHeader PmenuTitle

hi FlashLabel ctermbg=88 ctermfg=15 guibg=#990000 guifg=#FFFFFF cterm=bold gui=bold
