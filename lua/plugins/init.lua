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

  -- -- File Navigation
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end
  },

  -- Git
  { "airblade/vim-gitgutter" },

  -- LSP & Completion
  -- {
  --   "neoclide/coc.nvim",
  --   branch = "release",
  --   config = function()
  --     require("plugins.coc")
  --   end
  -- },

  -- Alternative LSP setup (choose one)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end
  },

  -- Commenting
  { "tpope/vim-commentary" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  },

  -- Language Support
  { "sheerun/vim-polyglot" },
  { "leafgarland/typescript-vim" },

  -- Text Objects
  { "kana/vim-textobj-user",     lazy = false, priority = 1000 },
  { "kana/vim-textobj-entire" },
  {
    "kana/vim-textobj-function",
    dependencies = { "kana/vim-textobj-user" },
    lazy = false,
    config = function()
      -- Ensure the plugin loads properly
      vim.cmd("runtime! plugin/textobj/function.vim")
    end,
  },
  {
    "thinca/vim-textobj-function-javascript",
    dependencies = {
      "kana/vim-textobj-user",
      "kana/vim-textobj-function"
    },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },

  -- Misc
  { "editorconfig/editorconfig-vim" },
  { "jiangmiao/auto-pairs" },

  -- Themes
  { "dracula/vim",                  name = "dracula" },
  { "olimorris/onedarkpro.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Prettier
  {
    "prettier/vim-prettier",
    build = "npm install --frozen-lockfile --production",
    ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "yaml", "html", "lua" }
  },

  -- Snippets
  { "SirVer/ultisnips" },

  -- TailwindCSS
  { "hrsh7th/nvim-cmp" },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },

  -- Image support
  { "3rd/image.nvim" },

  -- Firenvim
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
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

  -- Material icons
  { "DaikyXendo/nvim-material-icon" },

  -- Prisma
  { "prisma/vim-prisma",            ft = "prisma" },
}
