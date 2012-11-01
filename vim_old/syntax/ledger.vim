" Vim syntax file
" filetype: ledger
" Version: 0.0.2
" by Wolfgang Oertl
" Revision history
"  2005-02-05	first version (partly copied from ledger.vim 0.0.1)

if version < 600
	syntax clear
elseif exists("b:current_sytax")
	finish
endif

" for debugging
syntax clear

" region: a normal transaction
syn region transNorm start=/^\d/ skip=/^\s/ end=/^/ fold keepend transparent contains=transDate
syn match transDate /^\d\S\+/ contained
syn match Comment /^;.*$/
" highlight default link transNorm Question
highlight default link Comment SpecialKey
highlight default link transDate Question


" folding: how to represent a transaction in one line.
function! MyFoldText()
   let line = strpart(getline(v:foldstart), 0, 65)
   let line2 = getline(v:foldstart+1)
   let line2 = substitute(line2, ".*¤", "", "")
   let pad_len = 80 - strlen(line) - strlen(line2)
   if (pad_len < 0) then
      pad_len = 0
   endif
   let pad = strpart("                                                                                                                      ", 0, pad_len)
   return line . pad . line2
endfunction
set foldtext=MyFoldText()
set foldmethod=syntax

" syncinc is easy: search for the first transaction.
syn sync clear
syn sync match ledgerSync grouphere transNorm "^\d"


" syn match transNorm	"^\d.*$" contains=transDate,transClear,transPayee
" syn match transClear	"\*" contained
" syn match transPayee	"\<.*$" contained

" highlight def link transClear SpecialKey
" highlight def link transPayee ErrorMsg

let b:current_syntax = "ledger"

