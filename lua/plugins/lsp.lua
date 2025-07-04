return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require('lspconfig')
      
      -- Diagnostic signs
      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = " ",
        Info  = " ",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      
      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      
      -- TypeScript/JavaScript LSP
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Remove the ScrollViewRefresh command since it's causing errors
          -- You can add other on_attach functionality here
        end,
      })
      
      -- TailwindCSS LSP
      lspconfig.tailwindcss.setup{}
      
      -- Prisma LSP
      lspconfig.prismals.setup({
        cmd = { "prisma-language-server", "--stdio" },
        filetypes = { "prisma" },
        root_dir = lspconfig.util.root_pattern(".git", "package.json", "prisma"),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "tailwindcss", "prismals" },
      })
    end,
  },
}
