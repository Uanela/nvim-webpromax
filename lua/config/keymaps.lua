local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local map = vim.api.nvim_set_keymap

-- Search
keymap("n", "<CR>", ":nohlsearch<CR>", opts)
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Yank and Paste to system clipboard
keymap("v", "<leader>y", '"+y', opts)
keymap("v", "<C-c>", '"+y', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)

-- Insert mode clipboard
keymap("i", "<C-c>", '"+y', opts)
keymap("i", "<C-v>", '<C-o>:put .<CR>', opts)

-- File operations
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)
keymap("n", "<C-q>", ":wq<CR>", opts)
keymap("i", "<C-q>", "<Esc>:wq<CR>", opts)

-- Window navigation
keymap("n", "<C-1>", "1<C-w>w", opts)
keymap("n", "<C-2>", "2<C-w>w", opts)
keymap("n", "<C-3>", "3<C-w>w", opts)
keymap("n", "<C-4>", "4<C-w>w", opts)
keymap("n", "<C-5>", "5<C-w>w", opts)
keymap("n", "<C-6>", "6<C-w>w", opts)
keymap("n", "<C-7>", "7<C-w>w", opts)
keymap("n", "<C-8>", "8<C-w>w", opts)
keymap("n", "<C-9>", "9<C-w>w", opts)

-- Word manipulation in insert mode
keymap("i", "<C-e>", "<C-o>daw", opts)
keymap("i", "<C-d>", "<C-o>x", opts)
keymap("i", "<C-l>", "<C-o>D", opts)
keymap("i", "<C-i>", "<C-o>d0", opts)
keymap("i", "<C-j>", "<C-o>o", opts)

-- File tree
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>b", ":NvimTreeFocus<CR>", opts)

-- Buffer navigation
keymap("n", "<leader>]", ":BufferNext<CR>", opts)
keymap("n", "<leader>[", ":BufferPrevious<CR>", opts)
keymap("n", "<leader>x", ":BufferClose<CR>", opts)

-- Fuzzy finding
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-F>", ":Telescope live_grep<CR>", opts)

-- Git
keymap("n", "<leader>gs", ":Git<CR>", opts)
keymap("n", "<leader>ga", ":Git add .<CR>", opts)
keymap("n", "<leader>gc", ":Git commit<CR>", opts)
keymap("n", "<leader>gp", ":Git push<CR>", opts)

-- Commentary
keymap("v", "<leader>/", ":Commentary<CR>", opts)
keymap("i", "<C-/>", ":Commentary<CR>", opts)

-- Diagnostics
keymap("n", "d[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "d]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to Loclist" })

-- LSP
keymap("n", "K", vim.lsp.buf.hover, opts)

-- Duplicate file
keymap("n", "<leader>d", function()
  -- Check if current buffer is NvimTree
  local buf_ft = vim.bo.filetype
  if buf_ft == "NvimTree" then
    local src = vim.fn.expand('%')
    local dest = vim.fn.input('Duplicate to: ', src)
    if dest and dest ~= "" then
      vim.cmd('!cp ' .. src .. ' ' .. dest)
      print("File duplicated to " .. dest)
    end
  else
    print("This command only works inside NvimTree.")
  end
end, opts)

-- Delete without yanking
map('n', 'd', '"_d', opts)
map('n', 'D', '"_D', opts)
map('v', 'd', '"_d', opts)
map('v', 'D', '"_D', opts)

-- Change without yanking
map('n', 'c', '"_c', opts)
map('n', 'C', '"_C', opts)
map('v', 'c', '"_c', opts)
map('v', 'C', '"_C', opts)

-- x to not yank character
map('n', 'x', '"_x', opts)
map('v', 'x', '"_x', opts)

-- Restore real 'cut' behavior under <leader>d, <leader>c, <leader>x
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>c', 'c', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>x', 'x', { noremap = true })

-- Add to any lua config file
vim.keymap.set("n", "<leader>tt", function()
  local file = vim.fn.expand("%")
  if not (file:match("%.test%.") or file:match("%.spec%.")) then
    print("Not a test file!")
    return
  end

  -- Simple terminal runner
  vim.cmd("split")
  vim.cmd("term npx jest " .. vim.fn.shellescape(file))
end, { desc = "Run jest test file" })
