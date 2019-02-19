${HOME}/.gitconfig: git/gitconfig.symlink
	ln -sv `pwd`/$<  $@

antibody/zsh_plugins.sh: antibody/zsh_plugins.txt
	antibody bundle < $< > $@

${HOME}/.zshrc: zsh/zshrc.symlink
	ln -sv `pwd`/$<  $@

${HOME}/bin: bin
	ln -sv `pwd`/$< $@

.PHONY=link
link: ${HOME}/.gitconfig ${HOME}/.zshrc ${HOME}/bin antibody/zsh_plugins.sh

