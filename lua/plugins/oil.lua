return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  cmd = "Oil",
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
