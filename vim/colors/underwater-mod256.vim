" Maintainer: Mario Gutierrez (mario@mgutz.com)
" Original Theme: Dmitry Kichenko (dmitrykichenko@gmail.com)
" Last Change: Jun 23, 2010

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "underwater-mod"

" Vim >= 7.0 specific colors
if version >= 700
  " highlights current line
  hi CursorLine guibg=#18374F ctermbg=236
  " cursor's colour
  hi CursorColumn guibg=#ffffff ctermbg=15
  "hi MatchParen guifg=#ffffff ctermfg=15 guibg=#439ea9 ctermbg=73 gui=bold
  hi MatchParen         guifg=magenta   guibg=bg        gui=bold
  hi Pmenu 		guifg=#dfeff6 ctermfg=195   guibg=#1E415E ctermbg=23
  hi PmenuSel 	        guifg=#dfeff6 ctermfg=195   guibg=#2D7889 ctermbg=30

  " Search
  hi IncSearch          guifg=#E2DAEF ctermfg=7   guibg=#AF81F4 ctermbg=141   gui=bold
  hi Search             guifg=#E2DAEF ctermfg=7   guibg=#AF81F4 ctermbg=141   gui=none
endif

" General colors
hi Cursor 		guifg=NONE      guibg=#55A096 ctermbg=72   gui=none
hi Normal 		guifg=#e3f3fa ctermfg=195   guibg=#102235 ctermbg=235   gui=none
" e.g. tildes at the end of file
hi NonText 		guifg=#2F577C ctermfg=24   guibg=bg        gui=none
hi LineNr 		guifg=#233f59 ctermfg=237   guibg=bg        gui=none
hi StatusLine 	        guifg=#ffec99 ctermfg=228   guibg=#0a1721 ctermbg=233   gui=none
hi StatusLineNC         guifg=#233f59 ctermfg=237   guibg=#0a1721 ctermbg=233   gui=none
hi VertSplit 	        guifg=#0a1721 ctermfg=233   guibg=#0a1721 ctermbg=233   gui=none
hi Folded 		guifg=#68CEE8 ctermfg=80   guibg=#1A3951 ctermbg=237   gui=none
hi FoldColumn           guifg=#1E415E ctermfg=23   guibg=#1A3951 ctermbg=237   gui=none
hi Title		guifg=cyan      guibg=NONE	gui=bold
 " Selected text color
hi Visual		guifg=#dfeff6 ctermfg=195   guibg=#24557A ctermbg=24   gui=none
"hi SpecialKey	guifg=#3e71a1 ctermfg=61 guibg=#102235 ctermbg=235 gui=none

" Syntax highlighting
"
hi Comment 		guifg=#3e71a1 ctermfg=61 guibg=bg          gui=italic
hi Todo 		guifg=#ADED80 ctermfg=156 guibg=#579929 ctermbg=64     gui=bold
hi Constant 	        guifg=#96defa ctermfg=117 gui=none
hi String 		guifg=#89e14b ctermfg=113 gui=italic
 " names of variables in PHP
hi Identifier 	        guifg=#8ac6f2 ctermfg=117 gui=none
 " Function names as in python. currently purleish
hi Function 	        guifg=#AF81F4 ctermfg=141 gui=none
 " declarations of type, e.g. int blah
hi Type 		guifg=#41B2EA ctermfg=74 gui=none
 " statement, such as 'hi' right here
hi Statement 	        guifg=#68CEE8 ctermfg=80 gui=none
hi Keyword		guifg=#8ac6f2 ctermfg=117 gui=none
 "  specified preprocessed words (like bold, italic etc. above)
hi PreProc 		guifg=#ef7760 ctermfg=209 gui=none
hi Number		guifg=#96defa ctermfg=117 gui=none
hi Special		guifg=#DFEFF6 ctermfg=195 gui=none

" Ruby
hi rubyInterpolation            guifg=#b9e19d ctermfg=151 guibg=bg 
hi rubyInterpolationDelimiter   guifg=#b9e19d ctermfg=151 guibg=bg
hi link rubyStringDelimiter String
""hi erubyDelimiter guifg=#f8c6bd ctermfg=223 guibg=bg
hi link erubyDelimiter PreProc 

" HTML
hi link htmlTag Statement
hi link htmlEndTag Statement
hi link htmlTagName Statement 

" XML
hi link xmlTag htmlTag
hi link xmlEndTag htmlEndTag
hi link xmlTagName htmlTagName

" NERDTree
hi link treePart LineNr
hi link treePartFile treePart 
hi link treeDirSlash treePart
hi link treeDir Statement 
hi link treeClosable PreProc
hi link treeOpenable treeClosable
hi link treeUp treeClosable 
hi treeFlag guifg=#3e71a1 ctermfg=61 guibg=bg gui=none
hi link treeHelp Comment
hi link treeLink Type

hi link markdownCode Function
hi link markdownCodeBlock Function
