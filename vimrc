"mapleader
let mapleader=','

"Color Syntaxique
syntax on

"Colorscheme
set t_Co=256
"colorscheme vividchalk
colorscheme underwater-mod256

" General stuff
set nocompatible
set nu "Numbered Line
"set cursorcolumn " highlight the current column
"set cursorline " highlight current line
set incsearch " incremental search
set hlsearch " highlight search
set ignorecase
set smartcase
"set fdm=syntax "Folding by syntax
set showcmd "Show the command currently typed
"set tw=80 "End of line at 80 char

" Indentation stuff
set autoindent "Auto indent
set si "Smart indent
set tabstop=3
set expandtab "Convert tab to space
set shiftwidth=3
set softtabstop=3

" File encoding of new & saved file
set fileencoding=utf8

" Some stuff about windows
set splitbelow " Horizontal split below
set splitright " Vertical split on the right
let g:netrw_alto=1 " Horizontal split below with netrw
let g:netrw_altv=1 " Vertical split on the right with netrw

" Visual space and tab
set list
set listchars=tab:>.

" Persistent undo
set undodir=~/.vim/undodir/
set undofile
set undolevels=1000
set undoreload=10000

" Perl regex for god sake!
nnoremap / /\v
vnoremap / /\v


"------------------------------------------------
" Statut line

" Show the statut line
set laststatus=2

" Stalut line configuration
set statusline=%a\ %t%1*%m%*\ %{fugitive#statusline()}\ l:%l/%2*%L%*%6c%V

"%a si vous avez ouvert plusieurs fichiers, affiche le numéro de buffer sous la forme (1 of 4) pour le premier des quatre fichiers ;
"%t pour le nom du fichier sans le chemin ;
"%1* ce qui suit est affiché suivant le schéma de coloration User1 jusqu'au prochain motif %* (idem pour %2* et User2) ;
"%m affiche [+] lorsque le fichier est modifié et [-] s'il n'est pas modifiable ;
"%10l le numéro de ligne courante occupant au minimum la place de 10 caractères (c'est juste pour la mise en forme) ;
"%L le nombre de lignes du fichier ;
"%6c le numéro de la colonne courante sur 6 caractères ;
"%V le numéro de colonne virtuelle (tient compte de la place réellement occupée par les multi-caractères comme la tabulation, l'espace insécable, etc.)
"-------- Source http://www.point-libre.org/~dimitri/blog/index.php/2006/08/01/138

"------------------------------------------------
" Plugin

filetype plugin indent on 

"------------------------------------------------
" LaTeX plugins

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex 
" can be called correctly. 
set shellslash 
" IMPORTANT: grep will sometimes skip displaying the file name if you 
" search in a singe file. This will confuse Latex-Suite. Set your grep 
" program to always generate a file-name. 
set grepprg=grep\ -nH\ $* 
" OPTIONAL: This enables automatic indentation as you type. 
filetype indent on 

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Ledger files with .ldg extentions 
autocmd BufNewFile,BufRead *.ldg,*.ledger  :setf ledger 
