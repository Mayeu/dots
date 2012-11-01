set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set foldmethod=indent

" Changement de configuration lors des transitions
" mode commande & mode insertion
autocmd insertLeave * set nocursorline
autocmd insertEnter * set cursorline
autocmd insertLeave *.yml set nocursorcolumn
autocmd insertEnter *.yml set cursorcolumn
