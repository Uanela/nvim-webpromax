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
-- vim.keymap.set('n', '<leader>t1', function() M.toggle('leader') end, { desc = 'Toggle terminal 1' })
vim.keymap.set('n', '<C-t>1', function() M.toggle('ctrl-t-1') end, { desc = 'Toggle terminal 1' })
vim.keymap.set('n', '<C-t>2', function() M.toggle('ctrl-t-2') end, { desc = 'Toggle terminal 2' })
vim.keymap.set('n', '<C-t>3', function() M.toggle('ctrl-t-3') end, { desc = 'Toggle terminal 3' })
vim.keymap.set('n', '<C-t>4', function() M.toggle('ctrl-t-4') end, { desc = 'Toggle terminal 4' })
vim.keymap.set('n', '<C-t>5', function() M.toggle('ctrl-t-5') end, { desc = 'Toggle terminal 5' })
vim.keymap.set('n', '<C-t>6', function() M.toggle('ctrl-t-6') end, { desc = 'Toggle terminal 6' })

return M
