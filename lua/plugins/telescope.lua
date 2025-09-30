return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--hidden',
          '--glob=!**/.git/*',
          '--glob=!**/node_modules/*',
          '--glob=!**/dist/*',
          '--glob=!**/build/*',
          '--glob=!**/.build/*',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          ".build/"
        },
        mappings = {
          i = {
            ["<C-j>"] = "select_default"
          }
        }
      }
    }
    pickers = {
      find_files = {
        hidden = true,
      }
    }
  end,
}
