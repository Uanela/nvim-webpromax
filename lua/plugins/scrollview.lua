return {
  "dstein64/nvim-scrollview",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('scrollview').setup({
      -- Configure diagnostic signs

      -- local signs = {
      --   Error = "⏺",
      --   Warn  = "⏺",
      --   Hint  = "⏺",
      --   Info  = "⏺",
      -- }
      diagnostics_error_symbol = "",
      diagnostics_warn_symbol  = "",
      diagnostics_info_symbol  = "",
      diagnostics_hint_symbol  = "",

      -- diagnostics_error_symbol = "⏺",
      -- diagnostics_warn_symbol  = "⏺",
      -- diagnostics_info_symbol  = "⏺",
      -- diagnostics_hint_symbol  = "⏺",
      signs_on_startup         = { 'diagnostics' },
      diagnostics_severities   = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT }
    })

    vim.diagnostic.config({
      virtual_text = false,
      float = {
        border = "rounded",
        source = "always",
        wrap = true,
        max_width = 80,
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
    })

    vim.keymap.set('n', 'gl', function()
      vim.diagnostic.open_float({
        wrap = true,
        max_width = 80,
        border = "rounded",
        source = "always",
        format = function(diagnostic)
          local max_width = 77 -- Account for padding
          local message = diagnostic.message
          local lines = {}
          local pos = 1

          while pos <= #message do
            local chunk = message:sub(pos, pos + max_width - 1)

            -- If we're not at the end and next char isn't a space
            if pos + max_width <= #message then
              local last_space = chunk:match("^.*()%s")
              if last_space and last_space > max_width * 0.5 then
                chunk = chunk:sub(1, last_space - 1)
                pos = pos + last_space
              else
                pos = pos + max_width
              end
            else
              pos = pos + max_width
            end

            table.insert(lines, chunk)
          end

          return table.concat(lines, "\n")
        end,
      })
    end, { desc = 'Show diagnostic' })
  end,
}
