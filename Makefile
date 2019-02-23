
# Git Config
${HOME}/.gitconfig: git/gitconfig.symlink
	ln -sv `pwd`/$<  $@

# ZSH
antibody/zsh_plugins.sh: antibody/zsh_plugins.txt
	antibody bundle < $< > $@

${HOME}/.zshrc: zsh/zshrc.symlink
	ln -sv `pwd`/$<  $@

# My Bin
${HOME}/bin: bin
	ln -sv `pwd`/$< $@

# Spacemacs
${HOME}/.spacemacs: spacemacs/spacemacs.symlink
	ln -sv `pwd`/$< $@

${HOME}/.spacemacs.d: spacemacs/spacemacs.d.symlink
	ln -sv `pwd`/$< $@

.PHONY=link
link: ${HOME}/.gitconfig ${HOME}/.zshrc ${HOME}/bin antibody/zsh_plugins.sh ${HOME}/.spacemacs ${HOME}/.spacemacs.d

