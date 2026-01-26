local number = "10"
local name = "nvim-project-root"
local plugin_name = name:gsub("-challenge", "")

return {
  plugin_name,
  dir = "~/Documents/development/lua/solutions-nvim-plugin-challgens/" .. number .. "-" .. name,
  config = function()
    -- print("loading... " .. plugin_name)
    -- require(plugin_name).setup()
  end
}
