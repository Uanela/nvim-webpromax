return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set('n', '<leader>gs', function()
      vim.cmd('sp | 0Git')
    end, { desc = 'Git status in split' })
  end
}
