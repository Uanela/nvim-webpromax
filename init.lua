-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.autochdir = false

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.terminal")

-- Setup plugins
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

-- Load colorscheme after plugins
require("config.colorscheme")

-- Add Restat shortcut
vim.api.nvim_create_user_command("Restart", function()
  vim.cmd("SaveSession")
  vim.cmd("qall")
end, {})


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


