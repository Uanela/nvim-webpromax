return {
    "hrsh7th/nvim-cmp",
    version = "v2.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "mlaursen/vim-react-snippets",
    opts = function()
     require("vim-react-snippets").lazy_load()

     local config = require("vim-react-snippets.config")

     -- if you do not want to wrap all props in `Readonly<T>`
     config.readonly_props = false

     -- if you want to use vitest instead of `@jest/globals`
     -- config.test_framework = "vitest"

     -- if you want to use a custom test renderer path instead of
     -- `@testing-library/react`
     -- config.test_renderer_path = "@/test-utils"
    end
  }
}
    --- @param opts cmp.ConfigSchema
