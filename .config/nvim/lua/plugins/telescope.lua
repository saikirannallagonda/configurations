return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable("make") == 1
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    defaults = {
      prompt_prefix = ">", --"",
      file_ignore_patterns = {}, -- "node_modules", ".git/" },
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      layout_strategy = "vertical",
      show_disabled = true,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  },
  keys = {
    {
      "<leader>ff",
      function() require("telescope.builtin").find_files() end,
      desc = "Telescope find_files"
    },
    {
      "<leader>fg",
      function() require("telescope.builtin").live_grep() end,
      desc = "Telescope live_grep"
    },
    {
      "<leader>fb",
      function() require("telescope.builtin").buffers() end,
      desc = "Telescope Buffer List"
    },
    {
      "<leader>fh",
      function() require("telescope.builtin").help_tags() end,
      desc = "Telescope Find Help"
    },
  },
}
