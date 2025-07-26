-- ~/.config/nvim/lua/plugins/mason.lua
return {
  {
    "mason-org/mason.nvim",
    lazy = false,           -- eager load as recommended to fix PATH early
    opts = {
      -- Most essential options for mason.nvim; empty table is fine for default
      -- You can customize here if needed, e.g:
      -- PATH integration, registries, log_level, etc.
      PATH = "prepend",     -- Ensure Mason bin directory is added to PATH correctly
      -- Optional: customize UI
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.6,
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", },  -- servers to auto install
      automatic_installation = true,  -- auto install if missing on startup
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      -- Optional: pass any nvim-lspconfig global opts here;
      -- typically left empty to configure per-server manually.
      -- Or override handlers here if needed.
    },
  },
}

