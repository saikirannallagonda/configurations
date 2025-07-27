-- ~/.config/nvim/init.lua

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable({ "lua_ls", "html_ls", "css_ls", "js_ls", "java_ls" })


require("config.options")           -- Editor settings
require("config.keymaps")           -- Keymaps
require("config.autocmds")
require("config.lsp")
require("config.lazy")  -- Loads plugins from lua/plugins/*.lua

