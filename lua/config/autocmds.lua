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
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.json", "*.css", "*.md", "*.prisma", "*.lua", "*.py", "*.go", "*.rs", "*.java", "*.cpp", "*.h", "*.cc", "*.cxx", "*.hpp", "*.html", "*.mdx", "*.c" },
  callback = function(ev)
    local filetype = vim.bo[ev.buf].filetype
    local function format_with_lsp()
      pcall(vim.lsp.buf.format, { async = false })
    end
    if filetype == 'prisma' or filetype == 'lua' then
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
  pattern = { "javascriptreact", "typescriptreact", "tsx", "jsx" },
  callback = function()
    vim.bo.commentstring = "{/* %s */}"
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
    vim.cmd('lsp restart')
    vim.cmd('NvimTreeRefresh')
  end,
  { desc = "Runs LspRestart and NvimTreeRefresh for a complete IDE referesh." })

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local current = vim.api.nvim_get_current_buf()

    local bufs = vim.tbl_filter(function(b)
      return vim.api.nvim_buf_is_valid(b)
          and vim.bo[b].buflisted
          and vim.bo[b].buftype ~= "terminal"
          and b ~= current
    end, vim.api.nvim_list_bufs())

    if #bufs > 10 then
      table.sort(bufs, function(a, b)
        local a_used = (vim.fn.getbufinfo(a)[1] or {}).lastused or 0
        local b_used = (vim.fn.getbufinfo(b)[1] or {}).lastused or 0
        return a_used < b_used
      end)
      for i = 1, #bufs - 10 do
        vim.api.nvim_buf_delete(bufs[i], { force = false })
      end
    end
  end,
})

-- To prevent Oil from polluting nvim-tree
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local name = vim.api.nvim_buf_get_name(0)
--     if name:match("^oil:") then
--       return
--     end
--     vim.cmd("silent! lcd %:p:h")
--   end,
-- })
