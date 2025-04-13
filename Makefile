include make/boilerplate.mk

# Find all the file/folder ending with .symlink
file_to_symlink := $(shell find . -name '*.symlink')
# Extract just the name.symlink from the previous list
symlinks := $(patsubst %.symlink, %, $(shell basename $(file_to_symlink)))
# Generate the complete list of symlink target we need
#$(info "symlink")
#$(info $(symlinks))

symlinks_path := $(addprefix ${HOME}/., $(symlinks))

# All directory to search for *.symlink files/folder
dir := $(shell find . -type d -not -path '*/\.*')
$(info "dir")
$(info $(dir))
# VPATH tell make to search this list of folder when using the % pattern
VPATH = $(dir)

.PHONY: link install
link: install
install: $(symlinks_path)

# Create all symlink
${HOME}/.%: %.symlink
	ln -s $(abspath $<) $@

.PHONY: rebuild
rebuild:
	darwin-rebuild build --flake .#pro-m2

switch:
	sudo darwin-rebuild switch --flake .#pro-m2
