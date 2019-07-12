# Find all the file/folder ending with .symlink
file_to_symlink := $(shell find . -name '*.symlink')
# Extract just the name.symlink from the previous list
symlinks := $(patsubst %.symlink, %, $(shell basename $(file_to_symlink)))
# Generate the complete list of symlink target we need
symlinks_path := $(addprefix ${HOME}/., $(symlinks))

# All directory to search for *.symlink files/folder
dir := $(shell find . -type d -not -path '*/\.*')
# VPATH tell make to search this list of folder when using the % pattern
VPATH = $(dir)

install: $(symlinks_path) antibody/zsh_plugins.sh

# Create all symlink
${HOME}/.%: %.symlink
	ln -s $(abspath $<) $@

# ZSH
antibody/zsh_plugins.sh: antibody/zsh_plugins.txt
	antibody bundle < $< > $@
