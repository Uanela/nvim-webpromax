local function apply_custom_colors()
  local colors = {
    -- Background and foreground
    Normal = { fg = "#d1d1d1", bg = "none" },
    NormalNC = { fg = "#d1d1d1", bg = "none" },

    -- Line numbers
    LineNr = { fg = "#7b8baa", bg = "NONE" },
    LineNrNC = { fg = "#7b8baa", bg = "NONE" },
    CursorLineNr = { fg = "#cfcfcf", bg = "NONE" },

    -- Current line highlight
    CursorLine = { bg = "#0e0e0e" },

    -- Comments
    Comment = { fg = "#5c6370", italic = true },

    -- Keywords
    Keyword = { fg = "#c678dd" },
    Statement = { fg = "#c678dd" },
    Conditional = { fg = "#c678dd" },
    Repeat = { fg = "#c678dd" },

    -- Strings
    String = { fg = "#98c379" },
    Character = { fg = "#98c379" },

    -- Functions
    Function = { fg = "#61afef" },

    -- Variables and identifiers
    Identifier = { fg = "#e06c75" },

    -- Constants and numbers
    Constant = { fg = "#d19a66" },
    Number = { fg = "#d19a66" },
    Boolean = { fg = "#d19a66" },

    -- Types
    Type = { fg = "#e5c07b" },
    StorageClass = { fg = "#e5c07b" },

    -- Operators
    Operator = { fg = "#56b6c2" },

    -- Preprocessor
    PreProc = { fg = "#c678dd" },

    -- Special characters
    Special = { fg = "#c678dd" },

    -- Search highlighting
    Search = { bg = "#e5c07b", fg = "#282c34" },
    IncSearch = { bg = "#61afef", fg = "#282c34" },

    -- Visual selection
    Visual = { bg = "#3e4451" },

    -- Status line
    StatusLine = { bg = "#3e4451", fg = "#abb2bf" },
    StatusLineNC = { bg = "#2c323c", fg = "#5c6370" },

    -- Vertical split
    VertSplit = { fg = "#3e4451", bg = "NONE" },

    -- Popup menu
    Pmenu = { bg = "#2c323c", fg = "#abb2bf" },
    PmenuSel = { bg = "#3e4451", fg = "#abb2bf" },
    PmenuSbar = { bg = "#3e4451" },
    PmenuThumb = { bg = "#5c6370" },

    -- Git gutter colors
    GitGutterAdd = { fg = "#98c379" },
    GitGutterChange = { fg = "#e5c07b" },
    GitGutterDelete = { fg = "#e06c75" },

    -- Diagnostic colors
    DiagnosticError = { fg = "#e06c75" },
    DiagnosticWarn = { fg = "#e5c07b" },
    DiagnosticInfo = { fg = "#61afef" },
    DiagnosticHint = { fg = "#56b6c2" },

    -- CoC specific highlights
    CocErrorSign = { fg = "#e06c75" },
    CocWarningSign = { fg = "#e5c07b" },
    CocInfoSign = { fg = "#61afef" },
    CocHintSign = { fg = "#56b6c2" },

    -- Matching parentheses
    MatchParen = { bg = "#3e4451", fg = "#61afef", bold = true },

    -- Folded text
    Folded = { bg = "#2c323c", fg = "#5c6370" },

    -- Tab line
    TabLine = { bg = "#2c323c", fg = "#5c6370" },
    TabLineFill = { bg = "#2c323c" },
    TabLineSel = { bg = "#3e4451", fg = "#abb2bf" },

    -- End of buffer
    EndOfBuffer = { fg = "none", bg = "none" },
    EndOfBufferNC = { fg = "none", bg = "none" },

    -- Scrollview highlights
    ScrollViewDiagnosticError = { bg = "Red" },
    ScrollViewDiagnosticWarn = { bg = "Yellow" },
    ScrollViewDiagnosticInfo = { bg = "Blue" },
    ScrollViewDiagnosticHint = { bg = "Blue" },

    -- NvimTreeFolderIcon = { fg = "#888888" }
    -- NvimTreeFolderName = { fg = "#ffffff" }

  }


  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#8197AD" })
  vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#d1d1d1" })

  for group, opts in pairs(colors) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- Set colorscheme
vim.cmd.colorscheme("onedark")

-- Apply custom colors
apply_custom_colors()

-- Auto-apply colors after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_custom_colors,
})
