" Plugin names found in "~/.vim-addons" are activated on startup.
" Update manager and addons with ":UpdateAddons".
" Find addons with ":AddonsInfo <Tab>".
"
" VimKickStartR: https://github.com/v0n/vimkickstartr
" VAM: https://github.com/MarcWeber/vim-addon-manager

" Addon Manager Setup {{{
" You don't need to edit the following function.
" See ":help VAM-installation" for alternatives.
function! SetupVAM()
   let l:vam_install_path = expand('$HOME').'/.vim/vim-addons'
   let l:addons_file = expand('$HOME').'/.vim-addons'
   let l:addons = []
   let g:vim_addon_manager = {}
   let g:vim_addon_manager['auto_install'] = 1
   let g:vim_addon_manager['shell_commands_run_method'] = 'system'
   set nomore
   if !isdirectory(l:vam_install_path.'/vim-addon-manager/autoload')
      call mkdir(l:vam_install_path, 'p')
      let l:repo = 'https://github.com/MarcWeber/vim-addon-manager.git'
      let l:path = shellescape(l:vam_install_path, 1).'/vim-addon-manager'
      let l:doc = fnameescape(l:vam_install_path.'/vim-addon-manager/doc')
      silent execute '!git clone --depth=1' l:repo l:path
      execute 'helptags' doc
   endif
   execute 'set runtimepath+='.l:vam_install_path.'/vim-addon-manager'
   if filereadable(l:addons_file)
      let l:content = readfile(l:addons_file)
      call extend(l:addons, filter(l:content, 'v:val !~ "^\\s*$\\|^\""'))
   endif
   call vam#ActivateAddons(l:addons)
endfunction
call SetupVAM()
" }}}

" Type ":help <option>" for details

" First shit
set nocompatible

filetype on
filetype plugin on 
filetype indent on 

" File encoding of new & saved file
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf-8,ucs-bom,default,latin1

" Compiler support
compiler ruby

"mapleader
let mapleader=','

"Color Syntaxique
syntax on

"Colorscheme
set t_Co=256
set background=dark
colorscheme solarized

" General stuff
set nu "Numbered Line
"set cursorcolumn " highlight the current column
set cursorline " highlight current line
set incsearch " incremental search
set hlsearch " highlight search
set ignorecase
set smartcase
set showcmd "Show the command currently typed
set scrolloff=7
"set tw=80 "End of line at 80 char

" Indentation stuff
set autoindent "Auto indent
set si "Smart indent
set tabstop=3
set expandtab "Convert tab to space
set shiftwidth=3
set softtabstop=3
set smarttab

" Some stuff about windows
set splitbelow " Horizontal split below
set splitright " Vertical split on the right
let g:netrw_alto=1 " Horizontal split below with netrw
let g:netrw_altv=1 " Vertical split on the right with netrw

" Visual space and tab
set list
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
"set listchars=tab:>.,eol:¬,trail:-

"Invisible character colors (listchars related)
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59

" Persistent undo
set undodir=~/.vim/undodir/
set undofile
set undolevels=1000
set undoreload=10000

" Perl regex for god sake!
nnoremap / /\v
vnoremap / /\v

" Read my bashrc you filthy little shelly !
" not sure it is a good solution. Got some weird return
" and weird things...
"set shell=bash\ -l " like a login shell
"set shellcmdflag=-ic " the shell is now interactive

"------------------------------------------------
" Command

" su-write
command W w !sudo tee % > /dev/null

"------------
" Statut line
" -----------

" Show the statut line
set laststatus=2

" Stalut line configuration
"set statusline=%a\ %t%1*%m%*\ %{fugitive#statusline()}\ l:%l/%2*%L%*%6c%V

"%a si vous avez ouvert plusieurs fichiers, affiche le numéro de buffer sous la forme (1 of 4) pour le premier des quatre fichiers ;
"%t pour le nom du fichier sans le chemin ;
"%1* ce qui suit est affiché suivant le schéma de coloration User1 jusqu'au prochain motif %* (idem pour %2* et User2) ;
"%m affiche [+] lorsque le fichier est modifié et [-] s'il n'est pas modifiable ;
"%10l le numéro de ligne courante occupant au minimum la place de 10 caractères (c'est juste pour la mise en forme) ;
"%L le nombre de lignes du fichier ;
"%6c le numéro de la colonne courante sur 6 caractères ;
"%V le numéro de colonne virtuelle (tient compte de la place réellement occupée par les multi-caractères comme la tabulation, l'espace insécable, etc.)
"-------- Source http://www.point-libre.org/~dimitri/blog/index.php/2006/08/01/138

let g:airline_powerline_fonts = 1

" -----------
" Autocommand
" -----------

" Ledger files with .ldg extentions
autocmd BufNewFile,BufRead *.ldg,*.ledger set ft=ledger 

" Some tex file are not detected as tex file but plaintex
autocmd BufRead,BufNewFile *.tex set ft=tex

" YAML file
autocmd BufNewFile,BufRead *.yaml,*.yml set ft=yaml

" strip file on save
"au BufWritePre * :%!git stripspace < % <CR>

" --------------------
" Plugin configuration
" --------------------

" UltiSnips
" ---------

" Snip folder
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'

" Windows openning
let g:UltiSnipsEditSplit='vertical'

" Trigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Autoloading the vimrc when changed
" ----------------------------------
augroup VimrcReload
   au!
   autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
