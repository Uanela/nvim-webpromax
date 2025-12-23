return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)


      -- Diagnostic signs
      local signs = {
        Error = "",
        Warn  = "",
        Hint  = "",
        Info  = "",
      }

      -- local signs = {
      --   Error = "⏺",
      --   Warn  = "⏺",
      --   Hint  = "⏺",
      --   Info  = "⏺",
      -- }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- -- Diagnostic configuration
      -- vim.diagnostic.config({
      --   virtual_text = false,
      --   signs = false,
      --   underline = true,
      --   update_in_insert = false,
      --   severity_sort = true,
      -- })

      -- TypeScript/JavaScript LSP
      lspconfig.ts_ls.setup({
        on_attach = function()
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })

      -- TailwindCSS LSP
      lspconfig.tailwindcss.setup {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "tsx", 'jsx' },
        root_dir = lspconfig.util.root_pattern("tailwind.config.js", "package.json", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mts", ".git"),
        on_attach = function(client, bufnr)
          require('nvim-treesitter.configs').setup({
            highlight = { enable = true },
          })
        end,
        settings = {},
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      }

      lspconfig.cssls.setup({
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
      lspconfig.prismals.setup({
        cmd = { "prisma-language-server", "--stdio" },
        filetypes = { "prisma" },
        root_dir = lspconfig.util.root_pattern(".git", "package.json", "prisma"),
      })


      lspconfig.emmet_language_server.setup({
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
      lspconfig.omnisharp.setup {
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      }

      lspconfig.razor_ls.setup {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      }


      lspconfig.csharp_ls.setup {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      }

      lspconfig.lua_ls.setup({
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
        ensure_installed = { "ts_ls", "tailwindcss", "prismals", "emmet_language_server", "cssls", "lua_ls", "omnisharp" },
      })
    end,
  },
}
