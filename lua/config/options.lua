local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- Basic settings
opt.compatible = false
opt.number = true
opt.relativenumber = true
opt.foldmethod = "manual"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.clipboard = "unnamed"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.encoding = "utf-8"
opt.scrolloff = 5
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.lazyredraw = true
opt.ttyfast = true

-- Enable syntax highlighting
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Optimization
opt.history = 200

-- Search settings
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Wildmenu
opt.wildmenu = true
opt.wildmode = "full"

-- Terminal colors
opt.termguicolors = true

-- Disable netrw (we'll use nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

vim.opt.fillchars = {
  eob = " ", -- End of buffer (removes ~)
  fold = " ",
  foldsep = " ",
  diff = "╱",
}
