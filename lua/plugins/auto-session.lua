-- Auto session config
vim.o.sessionoptions = "curdir,tabpages,winsize,winpos,localoptions"
return {
 "rmagatti/auto-session",
 lazy = false,
 config = function()
   require("auto-session").setup {
     log_level = "info",
     -- auto_session_enable_last_session = true,
     auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
     -- auto_session_enabled = true,
     -- auto_save_enabled = true,
     -- auto_restore_enabled = true,
     auto_session_suppress_dirs = { 
      "~/", 
      "~/Projects",
      vim.fn.stdpath('config'), -- Add nvim config directory
       "~/.config/nvim",         -- Common nvim config path
       "~/.dotfiles"             -- If you have dotfiles there 
      },
     session_lens = {
       load_on_setup = false,
       theme_conf = { border = true },
       previewer = false,
     },
     -- pre_save_cmds = {
     --   "silent! %bdelete|edit#|bdelete#" -- Close hidden buffers
     -- },
     -- Change directory to file's directory
     auto_session_use_git_branch = false,
        }
   
   -- -- Auto-change to file's directory
   -- vim.api.nvim_create_autocmd("BufEnter", {
   --   callback = function()
   --     local file_dir = vim.fn.expand('%:p:h')
   --     if vim.fn.isdirectory(file_dir) == 1 then
   --       vim.cmd('cd ' .. file_dir)
   --     end
   --   end,
   -- })
   
   -- Limit to 15 buffers max - but don't delete current buffer
   vim.api.nvim_create_autocmd("BufEnter", {
     callback = function()
       local current_buf = vim.api.nvim_get_current_buf()
       local buffers = vim.fn.getbufinfo({buflisted = 1})
       
       if #buffers > 15 then
         -- Find oldest buffer that's not the current one
         for _, buf in ipairs(buffers) do
           if buf.bufnr ~= current_buf then
             vim.cmd("bdelete " .. buf.bufnr)
             break
           end
         end
       end
     end,
   })
  vim.api.nvim_create_user_command('SessionCleanAll', function()
    local session_dir = vim.fn.stdpath('data') .. '/sessions/'
    vim.fn.delete(session_dir, 'rf')
    vim.fn.mkdir(session_dir, 'p')
    print('All sessions cleaned!')
  end, {})
 end,
}
