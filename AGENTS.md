# AGENTS.md - Neovim Configuration

## Project Overview

This is a personal Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. The configuration is written in Lua.

## Directory Structure

```
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core configuration
│   │   └── lazy.lua         # Plugin manager setup
│   ├── custom/              # Personal customizations
│   │   ├── init.lua         # Custom module entry
│   │   ├── remap.lua        # Key mappings
│   │   └── ktlint.lua       # Kotlin linting config
│   └── plugins/             # Plugin configurations
│       ├── autocomplete.lua
│       ├── conform.lua
│       ├── debug.lua
│       ├── diffview.lua
│       ├── fidget.lua
│       ├── gitsigns.lua
│       ├── neotest.lua
│       ├── rose-pine.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── which-key.lua
│       └── java-lsp.lua
├── lsp/                     # LSP server configurations
│   ├── gopls.lua
│   ├── java-lsp.lua
│   ├── kotlin-lsp.lua
│   ├── luals.lua
│   ├── pyright.lua
│   ├── ruff.lua
│   ├── terraform-ls.lua
│   ├── texlab.lua
│   ├── typescript-language-server.lua
│   └── typos-lsp.lua
└── after/plugin/            # Post-load configurations
    ├── conform.lua
    ├── gitsigns.lua
    ├── lsp.lua              # LSP setup and keymaps
    ├── spaceing.lua
    └── telescope.lua
```

## Build/Lint/Test Commands

This is a Neovim configuration, not a compiled project. Use these commands within Neovim:

### Plugin Management
- `:Lazy` - Open lazy.nvim plugin manager UI
- `:Lazy sync` - Install, update, and clean plugins
- `:Lazy update` - Update all plugins
- `:Lazy check` - Check for updates

### Health Checks
- `:checkhealth` - Run Neovim health check
- `:checkhealth lazy` - Check lazy.nvim status
- `:checkhealth lsp` - Check LSP status

### Testing
- `:Neotest run` - Run nearest test (Python/Golang)
- `:Neotest summary` - Open test summary
- Keymaps: `<leader>tr` (run test), `<leader>td` (debug test), `<leader>tl` (run last)

### Formatting
- `:ConformInfo` - Check formatter status
- `:Format` - Format current buffer (if conform configured)

### Reloading Configuration
- `:source $MYVIMRC` - Reload init.lua
- Restart Neovim for full changes

## Code Style Guidelines

### Indentation
- Use **tabs** for indentation (observe existing patterns in treesitter.lua, lsp/*.lua)
- Tab width: follows `:set tabstop=4` (default)
- Some files use spaces - when editing existing files, match the file's style

### Quotes
- Both single (`'`) and double (`"`) quotes are used
- **Prefer single quotes** for plugin specs and simple strings
- Use double quotes when string contains single quotes

### File Structure

#### Plugin Files (lua/plugins/*.lua)
```lua
return {
  'plugin/name',
  dependencies = { 'dep1', 'dep2' },
  opts = {
    -- options
  },
}
```

#### LSP Files (lsp/*.lua)
```lua
return {
  cmd = { 'lsp-server', '--stdio' },
  filetypes = { 'filetype' },
  root_markers = { 'marker' },
  settings = {
    -- LSP settings
  },
}
```

### Naming Conventions
- **Files**: Use kebab-case (e.g., `autocomplete.lua`, `treesitter.lua`)
- **Lua modules**: Match directory structure (e.g., `lua.plugins.treesitter`)
- **Variables**: Use snake_case (`local my_var = ...`)
- **LSP names**: Use kebab-case matching server name (e.g., `pyright.lua`, `gopls.lua`)

### Imports and Requires
- Use `require("module.path")` format
- Group requires at top of file
- Example:
```lua
local neotest = require("neotest")
local config = require("my.config")
```

### Plugin Configuration Pattern
- Use `return { ... }` for plugin specs
- Use `config = function() ... end` for setup logic
- Use `opts = { ... }` for simple configurations
- Use `opts_extend` to merge default options

### LSP Configuration
- Place LSP configs in `lsp/` directory
- Enable LSPs in `after/plugin/lsp.lua` via `vim.lsp.enable()`
- Use `vim.api.nvim_create_autocmd("LspAttach", ...)` for buffer-local keymaps
- Use `vim.tbl_extend("force", opts, { desc = "..." })` for keymap options

### Key Mapping Conventions
- Leader key: `<space>` (set in `lua/custom/remap.lua`)
- Use descriptive `desc` in keymaps for which-key integration
- Pattern: `vim.keymap.set(mode, lhs, rhs, opts)`
- Prefer `noremap = true, silent = true` for general mappings

### Error Handling
- Check executable existence: `vim.fn.executable(path) == 1`
- Use `pcall` for protected calls when loading optional modules
- LSP: let `vim.lsp.enable()` handle server availability

### Comments
- Use `--` for single-line comments
- No inline comments at end of long lines
- Add comments sparingly, code should be self-documenting

### Formatting
- No strict line length limit, but prefer readability
- Use trailing commas in tables
- Align table keys when multiple settings exist
- Empty lines between logical sections

## Adding New Plugins

1. Create file in `lua/plugins/<plugin-name>.lua`
2. Return lazy.nvim spec with `return { ... }`
3. Use `opts = {}` for simple configs
4. Use `config = function() ... end` for complex setup
5. Run `:Lazy sync` to install

## Adding New LSP Servers

1. Create file in `lsp/<server-name>.lua`
2. Return table with `cmd`, `filetypes`, `root_markers`
3. Add server name to `vim.lsp.enable()` in `after/plugin/lsp.lua`
4. Ensure LSP server is installed on system

## Common Tasks

- **Change colorscheme**: Edit `lua/plugins/rose-pine.lua`
- **Add filetype support**: Update treesitter config and `after/plugin/lsp.lua`
- **Modify keymaps**: Edit `lua/custom/remap.lua` or LSP attach autocmd
- **Add formatters**: Configure in `lua/plugins/conform.lua`

## Notes

- No `.cursorrules` or `.github/copilot-instructions.md` found
- Configuration tested on Linux (Hyprland/Wayland)
- Some files mix tabs/spaces - match existing file style when editing
