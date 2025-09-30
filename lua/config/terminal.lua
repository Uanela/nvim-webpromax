local M = {}

function M.toggle(terminal_id)
  terminal_id = terminal_id or "default"
  
  -- Look for terminal with specific ID
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.getbufvar(buf, '&buftype') == 'terminal' and 
       vim.fn.getbufvar(buf, 'terminal_id') == terminal_id then
      -- Check if visible and toggle accordingly
      for win = 1, vim.fn.winnr('$') do
        if vim.fn.winbufnr(win) == buf then
          vim.cmd(win .. 'wincmd c')
          return
        end
      end
      vim.cmd('sbuffer ' .. buf)
      return
    end
  end
  
  -- Create new terminal with ID
  vim.cmd('split | terminal')
  vim.fn.setbufvar(vim.fn.bufnr('%'), 'terminal_id', terminal_id)
end

-- Different keymaps for different terminals
vim.keymap.set('n', '<leader>t', function() M.toggle('leader') end, { desc = 'Toggle terminal 1' })
vim.keymap.set('n', '<C-t>', function() M.toggle('ctrl') end, { desc = 'Toggle terminal 2' })

return M
