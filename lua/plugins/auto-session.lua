-- Auto session config
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,winpos,localoptions"
return {
 "rmagatti/auto-session",
 lazy = false,
 config = function()
   require("auto-session").setup {
     log_level = "info",
     auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
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
     auto_session_use_git_branch = false,
    }
   
  vim.api.nvim_create_user_command('SessionCleanAll', function()
    local session_dir = vim.fn.stdpath('data') .. '/sessions/'
    vim.fn.delete(session_dir, 'rf')
    vim.fn.mkdir(session_dir, 'p')
    print('All sessions cleaned!')
  end, {})
 end,
}
