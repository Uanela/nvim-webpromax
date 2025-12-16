return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npx jest", -- Use npx
          jestConfigFile = { "jest.config.ts", "jest.config.js", "jest.config.json" },
          cwd = vim.fn.getcwd(),
        }),
      },
    })
  end,
  keys = {
    {
      "<leader>tr",
      function()
        -- Only run if in a test file
        local file = vim.fn.expand("%")
        if not file:match("%.test%.ts$") and not file:match("%.spec%.ts$") then
          print("Not a test file:", file)
          return
        end
        require("neotest").run.run()
      end,
      desc = "Run nearest test"
    },
    {
      "<leader>tf",
      function()
        local file = vim.fn.expand("%")
        if not file:match("%.test%.ts$") and not file:match("%.spec%.ts$") then
          print("Not a test file:", file)
          return
        end
        require("neotest").run.run(file)
      end,
      desc = "Run current file"
    },
  },
}
