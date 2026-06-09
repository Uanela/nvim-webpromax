return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
  config = function()
    local ts = require('nvim-treesitter')

    ts.install({
      "tsx", "javascript", "typescript", "json", "html", "css",
      "lua", "python", "rust", "go", "prisma", "c_sharp"
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-treesitter-textobjects").setup {
      select = { lookahead = true },
      move   = { set_jumps = true },
    }

    -- Select textobjects (x = visual, o = operator-pending)
    local select = require("nvim-treesitter-textobjects.select")
    local function sel(key, query)
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(query, "textobjects")
      end)
    end

    sel("af", "@function.outer")
    sel("if", "@function.inner")
    sel("al", "@call.outer")
    sel("il", "@call.inner")
    sel("ac", "@class.outer")
    sel("ic", "@class.inner")
    sel("ap", "@parameter.outer")
    sel("ip", "@parameter.inner")
    sel("aa", "@loop.outer")
    sel("ia", "@loop.inner")
    sel("aC", "@conditional.outer")
    sel("iC", "@conditional.inner")
    sel("ab", "@block.outer")
    sel("ib", "@block.inner")
    sel("as", "@statement.outer")
    sel("am", "@comment.outer")
    sel("im", "@comment.inner")
  end,
}
