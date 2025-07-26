-- ~/.config/nvim/lua/config/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim if not installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Default options for lazy.nvim (customize as you like)
local opts = {
  defaults = {
    lazy = true,             -- lazy load plugins by default
    version = false,         -- use latest git commit, set to true or semver string to use tags
  },
  ui = {
    border = "rounded",
  },
  install = {
    missing = true,          -- install missing plugins on startup
    colorscheme = { "catppuccin", }, -- fallback colorschemes to install if none set
  },
  checker = {
    enabled = true,          -- automatic plugin update checker
    notify = false,          -- show a notification when updates found
    frequency = 86400,       -- check every day (in seconds)
  },
  change_detection = {
    enabled = true,          -- auto reload config when plugins.lua changes
    notify = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
    debug = false,
  },
}

-- Setup lazy.nvim with your plugins module, e.g. "plugins"
require("lazy").setup("plugins", opts)

