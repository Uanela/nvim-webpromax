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

augroup("AutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "AutoFormat",
  pattern = {
    "*.tsx", "*.vue", "*.ts", "*.js", "*.jsx", "*.json", "*.css", "*.md",
    "*.prisma", "*.lua", "*.py", "*.go", "*.rs", "*.java", "*.cpp",
    "*.h", "*.cc", "*.cxx", "*.hpp", "*.html", "*.mdx", "*.c"
  },
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local ext = vim.fn.expand("%:e")

    local prettier_parsers = {
      tsx = "typescript",
      ts = "typescript",
      js = "babel",
      jsx = "babel",
      json = "json",
      css = "css",
      md = "markdown",
      html = "html",
      mdx = "mdx",
      vue = "vue",
      prisma = "prisma",
    }

    if prettier_parsers[ext] then
      local view = vim.fn.winsaveview()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local input = table.concat(lines, "\n")

      local cmd_args = {
        "prettier",
        "--config",
        vim.fn.expand("~/.prettierrc"),
        "--parser",
        prettier_parsers[ext],
        "--stdin-filepath",
        buf_name,
      }

      if ext == "prisma" then
        table.insert(cmd_args, "--plugin=prettier-plugin-prisma")
      end

      local result = vim.system(cmd_args, {
        stdin = input,
        text = true,
      }):wait()

      if result.code == 0 then
        local formatted = vim.split(result.stdout, "\n", { plain = true })
        vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
        vim.fn.winrestview(view)
      else
        vim.notify(result.stderr, vim.log.levels.ERROR)
      end
    else
      vim.lsp.buf.format({ async = false })
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    vim.bo.commentstring = "/* %s */"
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
    -- require("nvim-tree.api").tree.change_root_to_node()
  end,
})

vim.api.nvim_create_user_command("Refresh",
  function()
    vim.cmd('lsp restart')
    vim.cmd('NvimTreeRefresh')
  end,
  { desc = "Runs LspRestart and NvimTreeRefresh for a complete IDE referesh." })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local current = vim.api.nvim_get_current_buf()
--
--     local bufs = vim.tbl_filter(function(b)
--       return vim.api.nvim_buf_is_valid(b)
--           and vim.bo[b].buflisted
--           and vim.bo[b].buftype ~= "terminal"
--           and b ~= current
--     end, vim.api.nvim_list_bufs())
--
--     if #bufs > 10 then
--       table.sort(bufs, function(a, b)
--         local a_used = (vim.fn.getbufinfo(a)[1] or {}).lastused or 0
--         local b_used = (vim.fn.getbufinfo(b)[1] or {}).lastused or 0
--         return a_used < b_used
--       end)
--       for i = 1, #bufs - 10 do
--         vim.api.nvim_buf_delete(bufs[i], { force = false })
--       end
--     end
--   end,
-- })
