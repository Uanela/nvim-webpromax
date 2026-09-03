return {
  "nvim-tree/nvim-tree.lua",
  -- dir = "~/Documents/development/lua/nvim-tree.lua",
  branch = "feat/add-download-from-path",
  dependencies = { "DaikyXendo/nvim-material-icon" },
  keys = {
    { "<leader>b", function() require('nvim-tree.api').tree.focus() end, desc = "Focus file explorer" },
    { "<C-b>",     "<cmd>NvimTreeToggle<cr>",                            desc = "Toggle file explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      hijack_directories = {
        enable = true
      },
      diagnostics = {
        enable = true
      },
      renderer = {
        icons = {
          webdev_colors = true,
        },
        group_empty = true,
        highlight_diagnostics = "name",
      },
      sort_by = "case_sensitive",
      view = {
        width = 32,
        side = "right",
      },
      filters = {
        dotfiles = false,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
        update_root = false,
        ignore_list = { ".git", "oil:" },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "<C-j>", api.node.open.edit)

        vim.api.nvim_create_autocmd({ "FocusGained" }, {
          callback = function()
            local buf = vim.api.nvim_get_current_buf()
            local ft = vim.api.nvim_buf_get_option(buf, "filetype")

            if ft == "NvimTree_1" then
              api.tree.resize({ width = { min = 32, max = 120 } })
            end
          end,
        })
      end,
    })
  end,
}
