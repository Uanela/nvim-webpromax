return {
  "neoclide/coc.nvim",
  branch = "release",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- CoC completion function
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- CoC keymaps
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    
    -- Use <C-Space> to trigger completion
    vim.keymap.set("i", "<C-Space>", 'coc#refresh()', opts)
    
    -- Use tab for trigger completion with characters ahead and navigate
    vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    vim.keymap.set("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', opts)
    
    -- Use <cr> to confirm completion
    vim.keymap.set("i", "<cr>", 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"', opts)
    
    -- CoC commands
    vim.api.nvim_create_user_command("Prettier", "call CocAction('runCommand', 'prettier.formatFile')", {})
  end,
}
