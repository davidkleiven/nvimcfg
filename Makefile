.PHONY: test

# Point these at plenary / the repo when running outside your home.
# CI overrides them via the workflow's `env:` block.
ENVRUN_REPO    ?= $(HOME)/.config/nvim
ENVRUN_PLENARY ?= $(HOME)/.local/share/nvim/lazy/plenary.nvim

# Which tests to run. Default = whole suite; pass TEST_FILE to run one file.
TEST_FILE ?= tests/envrun

test:
	ENVRUN_REPO='$(ENVRUN_REPO)' ENVRUN_PLENARY='$(ENVRUN_PLENARY)' \
	nvim --headless --noplugin -u tests/minimal_init.vim \
	  -c "PlenaryBustedDirectory $(TEST_FILE) {minimal_init = 'tests/minimal_init.vim', sequential = true}" \
	  -c "qa!"
