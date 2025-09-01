return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  cmd = "Oil", -- Only load when :Oil command is used
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
