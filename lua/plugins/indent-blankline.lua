return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│", -- Character for indent lines
      tab_char = "│",
      highlight = { "IblIndent" }, -- Use custom highlight group
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = false,
      highlight = { "Function", "Label" },
      priority = 500,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "json",
        "typescript",
        "javacript",
      },
    },
  },
  config = function(_, opts)
    -- Set up custom blue highlight for indent lines
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" }) -- Blue color
    
    require("ibl").setup(opts)
    
    -- Optional: Set different color specifically for TSX/JSX files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescriptreact", "javascriptreact" },
      callback = function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" }) -- Ensure blue for these files
      end,
    })
  end,
}
