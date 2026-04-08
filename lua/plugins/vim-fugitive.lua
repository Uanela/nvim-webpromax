return {
  "tpope/vim-fugitive",
  config = function()
    local keymap = vim.keymap.set

    local function toggle(window_id, cmd, should_split)
      should_split = should_split ~= false and true or false
      return function()
        for buf = 1, vim.fn.bufnr('$') do
          if vim.fn.getbufvar(buf, 'window_id') == window_id then
            for win = 1, vim.fn.winnr('$') do
              if vim.fn.winbufnr(win) == buf then
                vim.cmd(win .. 'wincmd c')
                return
              end
            end
          end
        end

        if should_split then
          vim.cmd('sp | 0' .. cmd)
        else
          vim.cmd(cmd)
        end

        vim.fn.setbufvar(vim.fn.bufnr('%'), 'window_id', window_id)
      end
    end

    keymap('n', '<leader>gs', toggle("GitStatus", "Git"), { desc = 'Git status in split' })
    keymap("n", "<leader>gb", toggle("GitBranch", "Git branch"), { desc = 'Git branch in split' })
    keymap("n", "<leader>gd", toggle("GitDiff", "Git diff"), { desc = 'Git diff in split' })
    keymap("n", "<leader>gc", toggle('GitCommit', "Git commit", false), { desc = 'Git commit in split' })
    keymap("n", "<leader>ga", ":Git add .<CR>")
    keymap("n", "<leader>gp", ":Git push<CR>")
  end
}
