local function apply_custom_colors()
  local colors = {
    Normal = { bg = "none" },
    NormalNC = { bg = "none" },

    LineNr = { fg = "#7b8baa", bg = "NONE" },
    LineNrNC = { fg = "#7b8baa", bg = "NONE" },
    CursorLineNr = { fg = "#cfcfcf", bg = "NONE" },

    -- -- Current line highlight
    CursorLine = { bg = "#0e0e0e" },

    -- -- Comments
    Comment = { fg = "#5c6370", italic = true },
    -- Comment = { italic = true },

    -- -- Keywords
    -- Keyword = { fg = "#c678dd" },
    -- Statement = { fg = "#c678dd" },
    -- Conditional = { fg = "#c678dd" },
    -- Repeat = { fg = "#c678dd" },

    -- -- Strings
    -- String = { fg = "#98c379" },
    -- Character = { fg = "#98c379" },

    -- -- Functions
    -- Function = { fg = "#61afef" },

    -- -- Variables and identifiers
    -- Identifier = { fg = "#e06c75" },

    -- -- Constants and numbers
    -- Constant = { fg = "#d19a66" },
    -- Number = { fg = "#d19a66" },
    -- Boolean = { fg = "#d19a66" },

    -- -- Types
    -- Type = { fg = "#e5c07b" },
    -- StorageClass = { fg = "#e5c07b" },

    -- -- Operators
    -- Operator = { fg = "#56b6c2" },

    -- -- Preprocessor
    -- PreProc = { fg = "#c678dd" },

    -- -- Special characters
    -- Special = { fg = "#c678dd" },

    -- -- Search highlighting
    -- Search = { bg = "#e5c07b", fg = "#282c34" },
    -- IncSearch = { bg = "#61afef", fg = "#282c34" },

    -- -- Visual selection
    -- Visual = { bg = "#3e4451" },

    -- -- Status line
    -- StatusLine = { bg = "#3e4451", fg = "#abb2bf" },
    -- StatusLineNC = { bg = "#2c323c", fg = "#5c6370" },

    -- -- Vertical split
    VertSplit = { fg = "#3e4451", bg = "NONE" },

    -- -- Popup menu
    Pmenu = { bg = "#2c323c", fg = "#abb2bf" },
    PmenuSel = { bg = "#3e4451", fg = "#abb2bf" },
    PmenuSbar = { bg = "#2b323e" }, -- Popup menu scrollbar
    PmenuThumb = { bg = "none" },   -- Popup menu scrollbar thumb

    -- Scrollbar column
    -- SignColumn = { bg = "#2b323e" },
    -- FoldColumn = { bg = "#2b323e" },

    -- -- Git gutter colors
    GitGutterAdd = { fg = "#98c379" },
    GitGutterChange = { fg = "#e5c07b" },
    GitGutterDelete = { fg = "#e06c75" },

    -- -- Diagnostic colors
    DiagnosticError = { fg = "#e06c75" },
    DiagnosticWarn = { fg = "#e5c07b" },
    DiagnosticInfo = { fg = "#61afef" },
    DiagnosticHint = { fg = "#56b6c2" },

    -- -- CoC specific highlights
    CocErrorSign = { fg = "#e06c75" },
    CocWarningSign = { fg = "#e5c07b" },
    CocInfoSign = { fg = "#61afef" },
    CocHintSign = { fg = "#56b6c2" },

    -- -- Matching parentheses
    MatchParen = { bg = "#3e4451", fg = "#61afef", bold = true },


    -- -- Tab line
    -- TabLine = { bg = "#2c323c", fg = "#5c6370" },
    -- TabLineFill = { bg = "#2c323c" },
    -- TabLineSel = { bg = "#3e4451", fg = "#abb2bf" },

    TabLine = { bg = "none", fg = "#5c6370", ctermbg = "none" },
    TabLineFill = { bg = "none", ctermbg = "none" },
    TabLineSel = { bg = "none", fg = "#abb2bf", ctermbg = "none" },

    -- Barbar buffer line
    BufferCurrent = { fg = "#abb2bf", bg = "#272c35" },
    BufferCurrentSign = { fg = "#4b5263", bg = "#2b323e" },
    BufferCurrentMod = { fg = "#e5c07b", bg = "#272c35" },
    BufferCurrentIcon = { bg = "none" },
    BufferVisible = { fg = "#5c6370", bg = "#2b323e" },
    BufferVisibleSign = { fg = "#4b5263", bg = "#2b323e" },
    BufferVisibleMod = { fg = "#e5c07b", bg = "#2b323e" },
    BufferVisibleIcon = { bg = "none" },
    BufferInactive = { fg = "#5c6370", bg = "#2b323e" },
    BufferInactiveSign = { fg = "#4b5263", bg = "#2b323e" },
    BufferInactiveMod = { fg = "#e5c07b", bg = "#2b323e" },
    BufferInactiveIcon = { bg = "#2b323e" },
    BufferTabpageFill = { bg = "#2b323e" },
    BufferTabpages = { fg = "#abb2bf", bg = "#2b323e" },

    -- -- End of buffer
    -- EndOfBuffer = { fg = "none", bg = "none" },
    -- EndOfBufferNC = { fg = "none", bg = "none" },

    -- Barbecue (winbar/breadcrumb)
    barbecue_normal = { fg = "#abb2bf", bg = "#2b323e" },
    barbecue_ellipsis = { fg = "#5c6370", bg = "#2b323e" },
    barbecue_separator = { fg = "#5c6370", bg = "#2b323e" },
    barbecue_modified = { fg = "#e5c07b", bg = "#2b323e" },
    barbecue_dirname = { fg = "#5c6370", bg = "#2b323e" },
    barbecue_basename = { fg = "#abb2bf", bg = "#2b323e" },
    barbecue_context = { fg = "#abb2bf", bg = "#2b323e" },


    -- Scrollview highlights
    ScrollViewDiagnosticError = { bg = "Red" },
    ScrollViewDiagnosticWarn = { bg = "Yellow" },
    ScrollViewDiagnosticInfo = { bg = "Blue" },
    ScrollViewDiagnosticHint = { bg = "Blue" },

    NvimTreeFolderIcon = { fg = "#6a7e90" },
    NvimTreeFolderName = { fg = "#d6dfe6" },
    NvimTreeNormalNc = { bg = "none" },
    NvimTreeNormal = { bg = "none" },
    NvimTreeCursorLine = { bg = "#2b323e" },   -- Selected item background
    NvimTreeCursorLineNr = { bg = "#2b323e" }, -- Line number for selected item

    WinSeparator = { fg = "#2b323e", bg = "#2b323e" },

    -- nvim-scrollbar specific
    ScrollView = { bg = "#5c6370" },

    -- Scrollbar on the right
  }



  for group, opts in pairs(colors) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- })
end

-- Set colorscheme
vim.cmd.colorscheme("monochrome")

-- Apply custom colors
apply_custom_colors()
vim.opt.termguicolors = true

-- Auto-apply colors after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_custom_colors,
})
