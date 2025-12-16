local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


-- Auto-create missing directories on save
augroup("AutoMkdir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoMkdir",
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Auto-format on save
augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
  group = "AutoFormat",
  pattern = { "*.py", "*.lua", "*.rs", "*.go", "*.java" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Prettier auto-format (with safety check)
autocmd("BufWritePre", {
  group = "AutoFormat",
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.json", "*.css", "*.md", "*.prisma", "*.lua", "*.py", "*.go", "*.rs", "*.java" },
  callback = function(ev)
    local function format_with_lsp()
      print("formatting with lsp")
      pcall(vim.lsp.buf.format, { async = false })
    end
    if vim.bo[ev.buf].filetype == 'prisma' then
      format_with_lsp()
    elseif vim.fn.exists(':PrettierAsync') == 2 then
      vim.cmd("PrettierAsync")
    elseif vim.fn.exists(':Prettier') == 2 then
      vim.cmd("Prettier")
    else
      -- Fallback to LSP formatting if Prettier isn't available
      format_with_lsp()
    end
  end,
})

-- Set filetype for React files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tsx",
  command = "set filetype=typescriptreact",
})

-- Set filetype for Prisma files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.prisma",
  command = "set filetype=prisma",
})

-- Comment string for JS/TS files
augroup("CommentString", { clear = true })
autocmd("FileType", {
  group = "CommentString",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

-- Diagnostics refresh for scrollview (with safety check)
augroup("DiagnosticRefresh", { clear = true })
autocmd({ "BufEnter", "CursorMoved", "DiagnosticChanged" }, {
  group = "DiagnosticRefresh",
  callback = function()
    -- Only run if scrollview is loaded and command exists
    if vim.fn.exists(':ScrollViewRefresh') == 2 then
      pcall(vim.cmd, "ScrollViewRefresh")
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. arg)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  once = true,
  callback = function()
    require("nvim-tree.api").tree.change_root_to_node()
  end,
})

vim.api.nvim_create_user_command("Refresh",
  function()
    vim.cmd('LspRestart')
    vim.cmd('NvimTreeRefresh')
    vim.cmd('CocRestart')
  end,
  { desc = "Runs CocRestart, LspRestart and NvimTreeRefresh for a complete IDE referesh." })
