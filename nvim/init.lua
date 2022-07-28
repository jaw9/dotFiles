require("chienan")

local core_conf_files = {
  "autocommands.vim",
  "mappings.vim",
  "plugins.vim",
  "set.vim"
}

for idx, fname in ipairs(core_conf_files) do
  local conf_path = vim.fn.stdpath("config") .. "/core/" .. fname
  vim.cmd("source " .. conf_path)
end
