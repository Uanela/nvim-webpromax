return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "tsx", "javascript", "typescript", "json", "html", "css",
        "lua", "python", "rust", "go", "prisma"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            ["al"] = "@call.outer",
            ["il"] = "@call.inner",

            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",

            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",

            -- ["aa"] = "@argument.outer",
            -- ["ia"] = "@argument.inner",

            ["aa"] = "@loop.outer",
            ["ia"] = "@loop.inner",

            ["aC"] = "@conditional.outer",
            ["iC"] = "@conditional.inner",

            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",

            ["as"] = "@statement.outer",
            ["is"] = "@statement.inner",

            ["am"] = "@comment.outer",
            ["im"] = "@comment.inner",
          },
        },
      },
    }
  end,
}
