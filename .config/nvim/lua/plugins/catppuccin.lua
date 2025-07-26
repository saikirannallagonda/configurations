return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- ensure colorscheme loads early
  lazy = false,
  opts = {
    flavour = "mocha",           -- choose from latte, frappe, macchiato, mocha
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = true,
      notify = false,
      mini = { enabled = true },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

