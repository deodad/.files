local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.showmode = false

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true
opt.background = "dark"

opt.scrolloff = 10
opt.isfname:append("@-@")

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
opt.signcolumn = "yes"


opt.updatetime = 100

opt.hidden = true

-- use ripgreg for search
opt.grepprg = "rg --vimgrep --smart-case --follow"
