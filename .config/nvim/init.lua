-- ~/.config/nvim/init.lua

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.


require("config.autocmds")
require("config.functions")
require("config.keymaps")
require("config.options")
require("config.tabs")
require("config.terminal")

require("config.lsp")
vim.lsp.enable({ "lua-lsp", "clangd", })
require("config.lazy")  -- Loads plugins from lua/plugins/*.lua

