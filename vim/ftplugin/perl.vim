" Vim filetype plugin file
" Only do this when not done yet for this buffer

if exists("b:did_PERL_ftplugin")
  finish
endif
let b:did_PERL_ftplugin = 1

" additional mapping : {<CR> always opens a block
inoremap    <buffer>  {<CR>  {<CR>}<Esc>O
vnoremap    <buffer>  {<CR> s{<CR>}<Esc>kp=iB

" Tabulation
set shiftwidth=4
set softtabstop=4
