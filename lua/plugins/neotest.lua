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
          jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")),
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end,                   desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,            desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output.open() end,               desc = "Show test output" },
  },
}
