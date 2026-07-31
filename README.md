# Neovim Configuration

AstroNvim v6 configuration for Neovim 0.12+.

## Structure

```text
lua/
├── community.lua       AstroCommunity imports
├── lazy_setup.lua      Lazy.nvim and AstroNvim setup
├── plugins/
│   ├── core/           Options, mappings, autocmds, highlights
│   ├── completion/     Blink and LuaSnip
│   ├── lsp/            Language servers and language tooling
│   ├── debug/          DAP
│   ├── format/         Formatters
│   ├── test/           Test runners
│   ├── treesitter/     Parsers and text objects
│   ├── editor/         Editing utilities
│   ├── search/         Telescope, Snacks, and search tools
│   ├── explorer/       File explorers
│   ├── terminal/       Terminal integration
│   ├── database/       Database tools
│   ├── runner/         Task runners
│   ├── git/            Git integrations
│   ├── ui/             Interface and themes
│   ├── ai/             AI integrations
│   └── misc/           Small standalone integrations
└── utils.lua           Shared Lua helpers
```

Plugin categories are imported explicitly from `lua/lazy_setup.lua`. Keep disabled or
reference configurations outside `lua/plugins/` so Lazy does not load them accidentally.

## Project-local LSP

Project-local configuration is enabled with Neovim's trusted `exrc` mechanism. In a
project root, create:

```text
.nvim.lua
.nvim/lsp/<server_name>.lua
```

Use `.nvim.lua` to add the project runtime directory:

```lua
local source = debug.getinfo(1, "S").source:sub(2)
vim.opt.runtimepath:append(vim.fs.dirname(source) .. "/.nvim")
```

Review the file and run `:trust` before allowing Neovim to execute it.

## Validation

```shell
nvim -i NONE --headless '+qa'
nvim -i NONE --headless '+lua vim.cmd("Lazy load all")' '+qa'
```
