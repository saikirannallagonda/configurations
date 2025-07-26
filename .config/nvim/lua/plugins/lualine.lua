return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin",
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { "toggleterm", "NvimTree", "neo-tree" },
      globalstatus = true,
      always_divide_middle = false,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diff",
          colored = true,
          symbols = { added = " ", modified = "柳 ", removed = " " },
          diff_color = {
            added = { fg = "#A6E22E" },
            modified = { fg = "#FD971F" },
            removed = { fg = "#F92672" },
          },
        },
        "diagnostics"
      },
      lualine_c = {
        {
          "filename",
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          shorting_target = 40, -- truncates path when statusline width less than this
          symbols = {
            modified = " ",  -- symbol for modified buffer
            readonly = " ",  -- symbol for readonly buffer
            unnamed = "[No Name]", -- text to show if buffer has no name
            newfile = "[New]", -- text to show for new file
          },
        },
      },
      lualine_x = {
        {
          "encoding",
          cond = function()
            return vim.fn.winwidth(0) > 80
          end,
        },
        "fileformat",
        "filetype"
      },
      lualine_y = {
        "progress",
        {
          function()
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
              return "No LSP"
            end
            local names = {}
            for _, client in ipairs(clients) do
              if client.name ~= "null-ls" then
                table.insert(names, client.name)
              end
            end
            return table.concat(names, ", ")
          end,
          icon = "",
          color = { fg = "#ffffff", gui = "bold" },
        },
      },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          path = 1,
          shorting_target = 40,
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "quickfix", "fzf", "nvim-tree", "neo-tree", "toggleterm", },
  },
}

