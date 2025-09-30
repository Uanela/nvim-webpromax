return {
  "APZelos/blamer.nvim",
  config = function()
    vim.g.blamer_enabled = 1              -- Enable on start
    vim.g.blamer_delay = 300              -- Reduced delay in milliseconds (default is 1000ms)
    vim.g.blamer_show_in_visual_modes = 0 -- Optional: disable in visual modes
    vim.g.blamer_show_in_insert_modes = 0 -- Optional: disable in insert modes
  end,
}
