return {
  "nvim-pack/nvim-spectre",
  keys = {
    { "<C-S-F>", function() require("spectre").open({ is_insert_mode = true }) end, desc = "Search and Replace (Spectre)" },
  },
  opts = {
    live_update = true, -- Update results as you type
  },
}
