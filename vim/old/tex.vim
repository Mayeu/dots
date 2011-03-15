" this is mostly a matter of taste. but LaTeX looks good with just a bit 
" of indentation. 
set sw=2 
" TIP: if you write your \labels as \label{fig:something} then if you 
" type in \ref{fig: and press <C-n> you will automatically cycle through 
" all the figure labels. Very useful! 
set iskeyword+=: 

"Remap des fonctions alt+x dans un tex. Le C-i en profite pour démapper
"le é.
imap <C-b> <Plug>Tex_MathBF
imap <C-c> <Plug>Tex_MathCal
imap <C-l> <Plug>Tex_LeftRight
imap <C-i> <Plug>Tex_InsertItemOnThisLine 

" LaTeX raccourcie math (necessite le fichier my_math.tex inclut)
" Ensemble mathématique
call IMAP('SMER', '\R', 'tex')
call IMAP('SMEN', '\N', 'tex')
call IMAP('SMEZ', '\Z', 'tex')
call IMAP('SMEQ', '\Q', 'tex')
call IMAP('SMEC', '\C', 'tex')
call IMAP('SMEU', '\U', 'tex')
call IMAP('SMEK', '\K', 'tex')

" Envirronnement math
call IMAP('EDF',"\\begin{definition}\<cr><++>\<cr>\\end{definition}<++>",'tex')
call IMAP('EDS',"\\begin{demo}\<cr><++>\<cr>\\end{demo}<++>",'tex')
call IMAP('ENT',"\\begin{notation}\<cr><++>\<cr>\\end{notation}<++>",'tex')
call IMAP('EPR',"\\begin{prop}\<cr><++>\<cr>\\end{prop}<++>",'tex')
call IMAP('EEX',"\\begin{exemple}\<cr><++>\<cr>\\end{exemple}<++>",'tex')
call IMAP('ENB',"\\begin{remarque}\<cr><++>\<cr>\\end{remarque}<++>",'tex')
call IMAP('ECX',"\\begin{cexemple}\<cr><++>\<cr>\\end{cexemple}<++>",'tex')

" Symbole Mathématique
call IMAP('SMPI', '\spi ', 'tex')
call IMAP('SMQS', '\sqqs ', 'tex')
call IMAP('SMEX', '\sex ', 'tex')
call IMAP('SMNEX', '\snex ', 'tex')
call IMAP('-->', '\simpld ', 'tex')
call IMAP('<--', '\simplg ', 'tex')
call IMAP('<=>', '\sequ ', 'tex')
call IMAP('SMET', '\sand ', 'tex')
call IMAP('SMOU', '\sou ', 'tex')
call IMAP('SMNEG', '\sneg ', 'tex')
call IMAP('-l->', '\snimpld ', 'tex')
call IMAP('<-l-', '\snimplg ', 'tex')
call IMAP('<l>', '\snequ ', 'tex')
call IMAP('SMIN', '\sinclut ', 'tex')
call IMAP('SMNIN', '\sninclut ', 'tex')
call IMAP('SMPO', '\sposd ', 'tex')
call IMAP('SMNPO', '\snposd ', 'tex')
call IMAP('SMEIN', '\ssubs ', 'tex')
call IMAP('SMNEIN', '\snsubs ', 'tex')
call IMAP('SMEPO', '\ssups ', 'tex')
call IMAP('SMNON', '\smneg ', 'tex')
call IMAP('SMCO', '\scompl{<++>}{<++>}<++>', 'tex')
call IMAP('SMUN', '\sunion ', 'tex')
call IMAP('SMIT', '\sinters ', 'tex')
call IMAP('SMEIQ', '\ssubeq ', 'tex')
call IMAP('SMEPQ', '\ssupeq ', 'tex')
call IMAP('SMEP', '\Pa(<++>)<++>', 'tex')
call IMAP('`{', '\{<++>\}<++>', 'tex')
call IMAP('SMUB', '\underbrace{<++>}<++>', 'tex')
call IMAP('->', '\lra ', 'tex')
call IMAP('l->', '\mapsto ', 'tex')
call IMAP('sqrt', '\sqrt{<++>}<++>', 'tex')
call IMAP('SMTAP', "\\begin{eqnarray*}\<cr><++>:<++> & \\longrightarrow & <++>\\\\\<cr><++> & \\mapsto & <++>\<cr>\\end{eqnarray*}<++>", 'tex')
call IMAP('SMAP', '$<++>:<++> \longrightarrow <++>$ <++>', 'tex')
call IMAP('SMBAP', '$<++> \mapsto <++>$ <++>', 'tex')
call IMAP('SMDI', '\not= ', 'tex')
call IMAP('>==', '\ge ', 'tex')
call IMAP('<==', '\le ', 'tex')
call IMAP('SMRO','\rond ','tex')
call IMAP('SMFR','\frestric{<++>}{<++>}<++>','tex')
call IMAP('SMGR','\ensuremath{(<++>,<++>)} <++>','tex')
call IMAP('SMBA','\sbar{<++>}<++>','tex')
call IMAP('SMVI','\svide','tex')
call IMAP('SMIM','\si','tex')
call IMAP("SMCE",'\classe{<++>}<++>','tex')
call IMAP('SMZL','\zl{<++>}<++>','tex')
call IMAP('SMCR','\stimes ','tex')
