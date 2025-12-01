# Neovim Configuration

Minimal, Lua-based Neovim config for TypeScript/JavaScript development.

## Structure

```
lua/
├── deodad/           # Core config
│   ├── init.lua      # Entry point (loads remap, set, lazy)
│   ├── lazy.lua      # Plugin manager bootstrap
│   ├── remap.lua     # Global keymaps (leader = Space)
│   └── set.lua       # Editor options
└── plugins/          # Plugin specs (lazy.nvim format)
    ├── base.lua      # UI (lualine, colorscheme, surround)
    ├── conform.lua   # Formatting (format on save)
    ├── git.lua       # Git (fugitive, gitsigns)
    ├── lsp.lua       # LSP, completion, lazydev
    ├── oil.lua       # File explorer
    ├── telescope.lua # Fuzzy finder
    └── treesitter.lua
```

## Key Design Decisions

- **lazy.nvim** for plugin management
- **Oil** as file explorer (not netrw)
- **Conform** for formatting (LSP formatting disabled for ts_ls)
- **Biome/Prettier** for JS/TS formatting via conform's LSP fallback
- **Melange** colorscheme (dark)
- **lazydev.nvim** for Lua API completion (no .luarc.json needed)

## Language Servers

Managed via Mason:
- `ts_ls` - TypeScript/JavaScript (formatting disabled)
- `eslint` - JS/TS linting
- `biome` - JS/TS formatting/linting
- `lua_ls` - Lua

## Important Keymaps

| Key | Action | Source |
|-----|--------|--------|
| `<leader>pv` | Oil file explorer | remap.lua |
| `<leader>g` | Git (fugitive) | remap.lua |
| `<leader>go` | Open on GitHub | remap.lua |
| `<leader>ff` | Find files | telescope.lua |
| `<leader>fg` | Live grep | telescope.lua |
| `<leader>fb` | Buffers | telescope.lua |
| `<C-p>` | Git files | telescope.lua |
| `<leader>f` | Format buffer | conform.lua |
| `gd` | Go to definition | lsp.lua |
| `gr` | References | lsp.lua |
| `K` | Hover docs | lsp.lua |
| `<leader>ca` | Code actions | lsp.lua |
| `<leader>rn` | Rename | lsp.lua |
| `]c` / `[c` | Next/prev git hunk | git.lua |
| `<leader>hs` | Stage hunk | git.lua |
| `<leader>hp` | Preview hunk | git.lua |
| `<leader>hb` | Blame line | git.lua |

## Common Tasks

### Add a plugin
Add to appropriate file in `lua/plugins/` using lazy.nvim spec format.

### Add an LSP server
1. Server is auto-available if Mason supports it
2. Add `vim.lsp.enable('server_name')` in lsp.lua
3. Add custom config with `vim.lsp.config('server_name', { ... })` if needed

### Add a formatter
Add to `formatters_by_ft` in `lua/plugins/conform.lua`. Mason auto-installs.

### Change keymaps
- Global: `lua/deodad/remap.lua`
- Plugin-specific: In the plugin's config/opts
- LSP: In `LspAttach` autocmd in `lua/plugins/lsp.lua`

## Style Guidelines

- Use `opts = {}` for simple configs, `config = function()` when logic needed
- Prefer lazy loading (`event`, `ft`, `cmd`, `keys`)
- Keep plugin files focused (one concern per file)
- No comments unless non-obvious

## Debugging

- `:Lazy` - Plugin manager UI
- `:Mason` - LSP/formatter manager
- `:LspInfo` - Active LSP clients
- `:checkhealth` - Diagnostic checks
- `:ConformInfo` - Formatter status
