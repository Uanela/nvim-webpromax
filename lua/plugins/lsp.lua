return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim"
    },
    config = function()
      local lsp = vim.lsp

      -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

      local signs = {
        Error = "",
        Warn  = "",
        Hint  = "",
        Info  = "",
      }


      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- TypeScript/JavaScript LSP
      lsp.config("ts_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        root_markers = { "tsconfig.json", }
      })

      lsp.config("deno_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        root_markers = { "deno.json", }
      })

      -- TailwindCSS LSP
      lsp.config("tailwindcss", {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "tsx", 'jsx' },
        root_markers = { "tailwind.config.js", "package.json", "tailwind.config.ts",
          "tailwind.config.cjs", "tailwind.config.mts", ".git" },
        on_attach = function(client, bufnr)
          require('nvim-treesitter.configs').setup({
            highlight = { enable = true },
          })
        end,
        settings = {},
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      lsp.config("cssls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          css = {
            validate = true, -- Enable CSS validation
          },
          less = {
            validate = true, -- Enable Less validation
          },
          scss = {
            validate = true, -- Enable SCSS validation
          },
        },
      })

      -- Prisma LSP
      lsp.config("prismals", {
        cmd = { "prisma-language-server", "--stdio" },
        filetypes = { "prisma" },
        root_markers = { ".git", "package.json", "prisma" },
      })


      lsp.config("emmet_language_server", {
        filetypes = {
          "astro",
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "php",
          "pug",
          "sass",
          "scss",
          "typescriptreact"
        },
      })

      -- Csharp
      lsp.config("omnisharp", {
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      lsp.config("razor_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })


      lsp.config("sharp_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      require("neodev").setup()
      lsp.config("lua_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              checkThirdParty = false
            },
            telemetry = {
              enable = false
            },
          }
        }
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
        ensure_installed = { "ts_ls", "tailwindcss", "prismals", "emmet_language_server", "cssls", "lua_ls", "omnisharp", "deno_ls" },
      })
    end,
  },
}
