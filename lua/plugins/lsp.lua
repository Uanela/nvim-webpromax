return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local lsp = vim.lsp
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local signs = {
        Error = "",
        Warn  = "",
        Hint  = "",
        Info  = "",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local vue_typescript_plugin = vim.fn.stdpath("data")
          .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

      lsp.config("ts_ls", {
        capabilities = default_capabilities,
        root_markers = { "pnpm-workspace.yaml", "turbo.json", "nx.json", ".git", "package.json", "tsconfig.json" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }, -- add "vue"
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_typescript_plugin,
              languages = { "vue" },
            },
          },
          preferences = {
            jsxAttributeCompletionStyle = "braces",
            quotePreference = "double",
          },
        },
        settings = {
          typescript = {
            format = {
              enable = true,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
              semicolons = "insert",
            },
          },
          javascript = {
            format = {
              enable = true,
              insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
              semicolons = "insert",
            },
          },
        },
      })
      lsp.enable("ts_ls")

      lsp.config("denols", {
        capabilities = default_capabilities,
        root_markers = { "deno.json" },
      })

      lsp.config("tailwindcss", {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = {
          "html", "java", "ftl", "css", "scss", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "vue", "tsx", "jsx",
        },
        root_markers = { "pnpm-workspace.yaml", "turbo.json", ".git", "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mts", "package.json" },
        capabilities = default_capabilities,
      })

      lsp.config("cssls", {
        capabilities = default_capabilities,
        settings = {
          css = { validate = true },
          less = { validate = true },
          scss = { validate = true },
        },
      })

      lsp.config("prismals", {
        cmd = { "prisma-language-server", "--stdio" },
        filetypes = { "prisma" },
        root_markers = { "pnpm-workspace.yaml", "turbo.json", ".git", "package.json", "prisma" },
      })

      lsp.config("emmet_language_server", {
        filetypes = {
          "astro", "css", "eruby", "html", "javascript",
          "javascriptreact", "less", "php", "pug", "sass",
          "scss", "typescriptreact", "vue", "ftl"
        },
      })

      lsp.config("omnisharp", {
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        capabilities = default_capabilities,
      })
      lsp.config("razor_ls", { capabilities = default_capabilities })
      lsp.config("sharp_ls", { capabilities = default_capabilities })

      lsp.config("pyright", { capabilities = default_capabilities })

      lsp.config("html", { capabilities = default_capabilities, filetypes = { "html", "vue", "template", "ftl" } })

      lsp.config("vue_ls", {
        capabilities = default_capabilities,
        root_markers = { "pnpm-workspace.yaml", "turbo.json", ".git", "package.json" },
        filetypes = { "vue" },
        init_options = {
          typescript = {
            tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
          },
        },
      })
      lsp.enable("vue_ls")

      lsp.config("clangd", {
        cmd = {
          "clangd",
          "--compile-commands-dir=build",
          "--fallback-style=llvm",
        },
        filetypes = { "c", "cpp", "cc", "c++", "tpp" },
        capabilities = default_capabilities,
      })

      require("neodev").setup()
      lsp.config("lua_ls", {
        capabilities = default_capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
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
        ensure_installed = {
          "ts_ls", "tailwindcss", "prismals", "emmet_language_server",
          "cssls", "lua_ls", "omnisharp", "denols", "pyright", "clangd", "html", "vue_ls", "jtdls"
        },
      })
    end,
  },
}
