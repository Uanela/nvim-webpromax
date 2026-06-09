return {
  -- Appearance
  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        colorscheme = 'one',
        active = {
          left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } }
        },
        component_function = {
          gitbranch = 'FugitiveHead'
        },
      }
    end
  },

  -- Git
  { "airblade/vim-gitgutter" },

  -- Language Support
  { "sheerun/vim-polyglot" },

  -- Text Objects
  { "kana/vim-textobj-user",    lazy = false,    priority = 1000 },
  { "kana/vim-textobj-entire" },

  -- Themes
  { "dracula/vim",              name = "dracula" },
  { "olimorris/onedarkpro.nvim" },
  { "folke/tokyonight.nvim" },
  { "fxn/vim-monochrome" },

  -- Prettier
  {
    "prettier/vim-prettier",
    build = "npm install --frozen-lockfile --production",
    ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "yaml", "html", "lua" }
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },

  -- Multi-cursor
  { "mg979/vim-visual-multi", branch = "master" },

  -- Scrollview
  {
    "dstein64/nvim-scrollview",
    config = function()
      require("plugins.scrollview")
    end
  },
}
