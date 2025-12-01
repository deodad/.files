return {
  'nvim-tree/nvim-web-devicons',
  'tpope/vim-surround',
  {
    'tpope/vim-fugitive',
    dependencies = 'tpope/vim-rhubarb',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
        },
      })
    end
  },
  {
    "savq/melange-nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'melange'
    end
  }
}
