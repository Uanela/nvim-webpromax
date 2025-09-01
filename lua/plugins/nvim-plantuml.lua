return {
 "weirongxu/plantuml-previewer.vim",
 ft = "plantuml",
 dependencies = { 
   "tyru/open-browser.vim",
   "aklt/plantuml-syntax"
 },
 config = function()
   -- Keymaps
   vim.keymap.set("n", "<leader>pp", ":PlantumlOpen<CR>", { desc = "Open PlantUML preview" })
   vim.keymap.set("n", "<leader>ps", ":!plantuml %<CR>", { desc = "Save PlantUML" })
   vim.keymap.set("n", "<leader>pt", ":PlantumlToggle<CR>", { desc = "Toggle PlantUML" })
 end,
}
