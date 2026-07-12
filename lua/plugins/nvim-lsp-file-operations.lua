return {
  {
    "Crysthamus/nvim-file-operations",
    dependencies = {
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("nvim-file-operations").setup()
    end,
  },
}
