return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "lua", "vim", "vimdoc",
          "json", "yaml", "html", "css", "markdown",
          "rust", "bash",
        },
        sync_install = false,
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}
