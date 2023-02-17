# This boilerplate provides:
# - sound default settings for make
# - usefull variables:
#   - root: the root of your project
#   - modules: path to the module folder
#   - makefile_path: path to the makefile being executed
#   - source: source the local env.sh if any
#   - the help target being run by default
#   - help generation provided by pretty-make (https://github.com/Awea/pretty-make)

# Use one shell for the whole recipe, instead of per-line
.ONESHELL:
# Use bash in strict mode
SHELL := bash
.SHELLFLAGS = -eu -o pipefail -c

# Delete target on error
# If the recipe fails, make will delete the non-phony target.
#
# This avoid case were the target is being created in the middle of a run and
# thus make will think everything is OK on the next run.
.DELETE_ON_ERROR:

# Sane makefile settings to avoid the unexpected
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# Absolute path to the project root
root := $(shell git rev-parse --show-toplevel)
# We give access to this to every targets
export root

# Absolute path to the artifacts root
artifacts_root = $(root)/artifacts

# Absolute path to modules
modules := $(root)/modules
export modules

# Absolute path to the executed Makefile, and its directory
# NOT the makefile we are in
makefile_path := $(abspath $(firstword $(MAKEFILE_LIST)))
makefile_dir := $(dir makefile_path)

# Provide a command to source the env.sh file if any
source ?= source env.sh || true

# Everything needed to generate helps
.DEFAULT_GOAL := help

.PHONY: help
## List available commands
help: $(root)/bin/pretty-make
	@"$<" pretty-help "$(makefile_path)"

$(root)/bin:
	@mkdir -p $@

$(root)/bin/pretty-make:
	@cd $(root)
	curl -Ls https://raw.githubusercontent.com/awea/pretty-make/master/scripts/install.sh | bash -sx
