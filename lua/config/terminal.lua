local M = {}

function M.toggle()
  -- Look for an existing terminal buffer
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.getbufvar(buf, '&buftype') == 'terminal' then
      -- Check if this buffer is visible in any window
      for win = 1, vim.fn.winnr('$') do
        if vim.fn.winbufnr(win) == buf then
          -- Close the window showing the terminal
          vim.cmd(win .. 'wincmd c')
          return
        end
      end
      -- Terminal exists but not visible, show it
      vim.cmd('sbuffer ' .. buf)
      return
    end
  end
  -- No terminal buffer found, create one
  vim.cmd('split | terminal')
end

-- Set up keymaps directly
vim.keymap.set('n', '<leader>t', M.toggle, { desc = 'Toggle terminal' })
vim.keymap.set('n', '<C-t>', M.toggle, { desc = 'Toggle terminal' })

-- Make the toggle function globally available
_G.terminal_toggle = M.toggle

return M
-- local M = {}

-- function M.toggle()
--   local current_win = vim.api.nvim_get_current_win()
--   local current_col = vim.fn.wincol()
  
--   -- Create a unique key for this column position
--   local col_key = 'terminal_col_' .. current_col
  
--   -- Look for existing terminal for this column
--   local terminal_buf = vim.g[col_key]
  
--   if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
--     -- Check if terminal is visible in current column
--     local terminal_win = vim.fn.bufwinnr(terminal_buf)
--     if terminal_win ~= -1 then
--       -- Terminal is visible, close it safely
--       local win_id = vim.fn.win_getid(terminal_win)
--       if vim.api.nvim_win_is_valid(win_id) then
--         vim.api.nvim_win_close(win_id, false)
--       end
--       return
--     else
--       -- Terminal exists but not visible, show it
--       vim.cmd('split')
--       vim.api.nvim_win_set_buf(0, terminal_buf)
--       return
--     end
--   end
  
--   -- No terminal for this column, create one
--   vim.cmd('split | terminal')
--   local new_terminal_buf = vim.api.nvim_get_current_buf()
  
--   -- Store the terminal buffer for this column
--   vim.g[col_key] = new_terminal_buf
  
--   -- Clean up when terminal is closed
--   vim.api.nvim_create_autocmd("BufDelete", {
--     buffer = new_terminal_buf,
--     callback = function()
--       vim.g[col_key] = nil
--     end,
--     once = true
--   })
-- end

-- -- Set up keymaps
-- vim.keymap.set('n', '<leader>t', M.toggle, { desc = 'Toggle terminal' })
-- vim.keymap.set('n', '<C-t>', M.toggle, { desc = 'Toggle terminal' })

-- return M
