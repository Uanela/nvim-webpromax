return {
 "nvim-tree/nvim-tree.lua",
 commit = "543ed3c",
 dependencies = { "DaikyXendo/nvim-material-icon" },
 keys = {
  { "<leader>e", function() require('nvim-tree.api').tree.focus() end, desc = "Focus file explorer" },
  { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
 },
 config = function()
    local tree_opened = false
    require("nvim-tree").setup({

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
     },
     update_focused_file = {
       enable = true,
       update_cwd = false,
       update_root = false,
       ignore_list = {},
     },
     on_attach = function(bufnr)
       local api = require("nvim-tree.api")

       if not tree_opened then
          tree_opened = true
          api.tree.change_root_to_node()
       end
      api.config.mappings.default_on_attach(bufnr)
      
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
 -- opts = function(_, opts)
 --    local api = require("nvim-tree.api")

 --    local function rename_with_lsp(node)
 --      local old_path = node.absolute_path
 --      vim.ui.input({ prompt = "Rename to: ", default = node.name }, function(new_name)
 --        if not new_name or new_name == "" or new_name == node.name then return end
 --        local new_path = vim.fn.fnamemodify(old_path, ":h") .. "/" .. new_name

 --        -- Rename the file on disk
 --        vim.loop.fs_rename(old_path, new_path)

 --        -- Trigger LSP to update imports
 --        for _, client in pairs(vim.lsp.get_active_clients()) do
 --          if client.supports_method("workspace/willRenameFiles") then
 --            client.request("workspace/willRenameFiles", {
 --              files = { {
 --                oldUri = vim.uri_from_fname(old_path),
 --                newUri = vim.uri_from_fname(new_path),
 --              } },
 --            }, function(err, res)
 --              if err then return end
 --              if res and res.documentChanges then
 --                vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)
 --              end
 --            end)
 --          end
 --        end

 --        -- Refresh nvim-tree
 --        api.tree.reload()
 --      end)
 --    end

 --    opts.on_attach = function(bufnr)
 --      api.config.mappings.default_on_attach(bufnr)
 --      vim.keymap.set("n", "r", function()
 --        local node = api.tree.get_node_under_cursor()
 --        if node and node.absolute_path then
 --          rename_with_lsp(node)
 --        end
 --      end, { buffer = bufnr, desc = "Rename (with LSP imports update)" })
 --    end
 --  end,
 opts = function(_, opts)
  local api = require("nvim-tree.api")
  
  local function rename_with_lsp(node)
    local old_path = node.absolute_path
    local old_name = node.name
    local parent_dir = vim.fn.fnamemodify(old_path, ":h")
    
    -- Allow both renaming and moving by accepting full paths
    local prompt_text = "Rename/Move to (use full path for moving): "
    local default_value = old_name
    
    vim.ui.input({ prompt = prompt_text, default = default_value }, function(input)
      if not input or input == "" or input == old_name then 
        return 
      end
      
      local new_path
      -- Check if input contains path separators (moving to different directory)
      if input:match("[/\\]") then
        -- Full path provided
        if not vim.startswith(input, "/") then
          -- Relative path, make it absolute from current parent
          new_path = parent_dir .. "/" .. input
        else
          -- Already absolute path
          new_path = input
        end
      else
        -- Just a filename, rename in same directory
        new_path = parent_dir .. "/" .. input
      end
      
      -- Normalize path
      new_path = vim.fn.resolve(new_path)
      
      -- Create target directory if it doesn't exist
      local target_dir = vim.fn.fnamemodify(new_path, ":h")
      if vim.fn.isdirectory(target_dir) == 0 then
        vim.fn.mkdir(target_dir, "p")
      end
      
      -- Collect active LSP clients that support rename operations
      local lsp_clients = {}
      for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.supports_method("workspace/willRenameFiles") then
          table.insert(lsp_clients, client)
        end
      end
      
      -- If we have LSP clients, use LSP-assisted rename
      if #lsp_clients > 0 then
        local params = {
          files = {{
            oldUri = vim.uri_from_fname(old_path),
            newUri = vim.uri_from_fname(new_path),
          }}
        }
        
        -- Counter to track completed requests
        local completed = 0
        local total = #lsp_clients
        local all_edits = {}
        
        local function apply_edits_and_rename()
          -- Apply all collected workspace edits
          for _, edit_data in ipairs(all_edits) do
            vim.lsp.util.apply_workspace_edit(edit_data.edit, edit_data.encoding)
          end
          
          -- Perform the actual file rename/move
          local success, err = pcall(vim.loop.fs_rename, old_path, new_path)
          if not success then
            vim.notify("Failed to rename/move file: " .. tostring(err), vim.log.levels.ERROR)
            return
          end
          
          -- Refresh nvim-tree
          api.tree.reload()
          
          -- Open the moved file if it was currently open
          local bufnr = vim.fn.bufnr(old_path)
          if bufnr ~= -1 then
            vim.api.nvim_buf_set_name(bufnr, new_path)
          end
          
          vim.notify("File renamed/moved successfully")
        end
        
        -- Send willRenameFiles request to all supporting clients
        for _, client in ipairs(lsp_clients) do
          client.request("workspace/willRenameFiles", params, function(err, result)
            if err then
              vim.notify("LSP rename request failed: " .. tostring(err), vim.log.levels.WARN)
            else
              if result and (result.documentChanges or result.changes) then
                table.insert(all_edits, {
                  edit = result,
                  encoding = client.offset_encoding
                })
              end
            end
            
            completed = completed + 1
            if completed == total then
              apply_edits_and_rename()
            end
          end)
        end
      else
        -- No LSP support, just do the file operation
        local success, err = pcall(vim.loop.fs_rename, old_path, new_path)
        if not success then
          vim.notify("Failed to rename/move file: " .. tostring(err), vim.log.levels.ERROR)
          return
        end
        
        api.tree.reload()
        vim.notify("File renamed/moved successfully (no LSP support)")
      end
    end)
  end
  
  opts.on_attach = function(bufnr)
    api.config.mappings.default_on_attach(bufnr)
    
    vim.keymap.set("n", "r", function()
      local node = api.tree.get_node_under_cursor()
      if node and node.absolute_path and node.type == "file" then
        rename_with_lsp(node)
      end
    end, { buffer = bufnr, desc = "Rename/Move file (with LSP imports update)" })
  end
end
}
