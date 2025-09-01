return {
  "nvim-pack/nvim-spectre",
  keys = {
    { "<C-S-F>", function() require("spectre").toggle({ is_insert_mode = true }) end, desc = "Search and Replace (Spectre)" },
  },
  opts = {
    live_update = true,
    open_cmd = 'enew',
  },
  config = function(_, opts)
    local spectre = require("spectre")
    spectre.setup(opts)

    -- Auto-restore previous buffer when spectre closes
    vim.api.nvim_create_autocmd("User", {
      pattern = "SpectreClose",
      callback = function()
        if vim.g.spectre_previous_buffer and vim.api.nvim_buf_is_valid(vim.g.spectre_previous_buffer) then
          vim.api.nvim_set_current_buf(vim.g.spectre_previous_buffer)
        end
      end,
    })
  end
}
