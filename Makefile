${HOME}/.gitconfig: git/gitconfig.symlink
	ln -sv `pwd`/$<  $@

${HOME}/.zshrc: zsh/zshrc.symlink
	ln -sv `pwd`/$<  $@
