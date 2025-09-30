return {
  "dstein64/nvim-scrollview",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('scrollview').setup({
      -- Configure diagnostic signs
      diagnostics_error_symbol = "",
      diagnostics_warn_symbol  = "",
      diagnostics_info_symbol  = "",
      diagnostics_hint_symbol  = "",
      signs_on_startup         = { 'diagnostics' },
      diagnostics_severities   = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT }
    })

    -- Configure diagnostic virtual text to wrap
    vim.diagnostic.config({
      virtual_text = {
        wrap = true,
        spacing = 2,
        format = function(diagnostic)
          -- Wrap long messages
          local max_width = vim.api.nvim_win_get_width(0) - vim.fn.col('.') - 5
          if #diagnostic.message > max_width then
            return string.sub(diagnostic.message, 1, max_width) .. "..."
          end
          return diagnostic.message
        end,
      },
    })
  end,
}
