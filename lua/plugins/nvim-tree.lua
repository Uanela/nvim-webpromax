return {
 "nvim-tree/nvim-tree.lua",
 -- dependencies = { "nvim-tree/nvim-web-devicons" },
 dependencies = { "DaikyXendo/nvim-material-icon" },
 keys = {
  { "<leader>e", function() require('nvim-tree.api').tree.focus() end, desc = "Focus file explorer" },
  { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
 },
 config = function()
    local tree_opened = false
   require("nvim-tree").setup({
     -- sync_root_with_cwd = true,  -- This will sync the root with current working directory
     -- respect_buf_cwd = true,

     renderer = {
       icons = {
         webdev_colors = true,
       },
       group_empty = true,
     },
     sort_by = "case_sensitive",
     view = {
       width = 30,
       side = "right"
     },
     filters = {
       dotfiles = false,
       -- custom = { ".git" },
     },
     update_focused_file = {
       enable = true,
       update_cwd = false,
       update_root = false,
       ignore_list = {},
     },
         -- actions = {
     --   open_file = {
     --     window_picker = {
     --       enable = true,
     --       picker = "default",
     --       chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
     --     },
     --   },
     -- },
     on_attach = function(bufnr)
       local api = require("nvim-tree.api")

       if not tree_opened then
          tree_opened = true
          api.tree.change_root_to_node()
       end
       -- Use all default mappings
      api.config.mappings.default_on_attach(bufnr)
      
      -- Only override file opening behavior
      vim.keymap.set('n', '<C-j>', function()
        local node = api.tree.get_node_under_cursor()
        if node.type == "file" then
          local last_win = vim.fn.winnr('#')
          if last_win > 0 and vim.api.nvim_win_is_valid(last_win) then
            vim.cmd(last_win .. "wincmd w")
            vim.cmd("edit " .. node.absolute_path)
          else
            api.node.open.edit()
          end
        end
      end, { buffer = bufnr })
      
      end,
   })
 end,
}
