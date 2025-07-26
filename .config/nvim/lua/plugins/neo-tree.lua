return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",  -- stable branch to avoid breaking changes
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- for file icons
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
      end,
      desc = "Toggle NeoTree (cwd)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Toggle NeoTree (git status)",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Toggle NeoTree (buffers)",
    },
  },
  opts = {
    popup_border_style = "rounded",
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = { enabled = true },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
    },
    window = {
      width = 40,
      mappings = {
        ["<cr>"]  = "open",              -- open file or directory
        ["o"]     = "open",              -- alternative open
        ["l"]     = "open",              -- open with focus
        ["h"]     = "close_node",        -- close directory node
        ["v"]     = "open_vsplit",        -- open file in vertical split
        ["s"]     = "open_split",         -- open file in horizontal split
        ["t"]     = "open_tabnew",        -- open file in new tab
        ["a"]     = "add",               -- create new file or directory
        ["d"]     = "delete",             -- delete file or directory
        ["r"]     = "rename",             -- rename file or directory
        ["y"]     = "copy_to_clipboard",     -- copy file path to clipboard
        ["x"]     = "cut_to_clipboard",       -- cut file path to clipboard
        ["p"]     = "paste_from_clipboard",   -- paste from clipboard
        ["c"]     = "copy",                -- copy file
        ["m"]     = "move",                -- move file
        ["R"]     = "refresh",             -- refresh tree
        ["n"]     = "toggle_node",       -- expand/collapse directory
        ["H"]     = "toggle_hidden",       -- toggle hidden files
        ["?"]     = "show_help",         -- show help
        ["<bs>"]  = "noop",  -- disables backspace from going to parent folder
        ["/"]     = "fuzzy_finder",
        ["D"]     = "fuzzy_finder_directory",
        ["#"]     = "fuzzy_sorter",
        ["f"]     = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["P"]     = {
          "toggle_preview",
          config = {use_float = true },
        },
      },
    },
    git_status = {
      symbols = {
        added = "+",
        modified = "~",
        deleted = "-",
        untracked = "?",
        ignored = "!",
        renamed = "R",
        unstaged = "U",
        staged = "S",
        conflict = "C",
      },
    },
  },
}
