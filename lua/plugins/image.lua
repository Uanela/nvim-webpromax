return {
  "3rd/image.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("image").setup({
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = false,
          clear_in_insert_mode = false,
        },
      },
    })
  end
}
