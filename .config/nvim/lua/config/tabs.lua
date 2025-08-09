--der/ ~/.config/nvim/lua/config/tabs.lua
--
-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 1  -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''     -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Alternative navigation (more intuitive)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })

-- Function to open file in new tab
local function open_file_in_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. input)
    end
  end)
end

-- Function to duplicate current tab
local function duplicate_tab()
  local current_file = vim.fn.expand('%:p')
  if current_file ~= '' then
    vim.cmd('tabnew ' .. current_file)
  else
    vim.cmd('tabnew')
  end
end

-- Function to close tabs to the right
local function close_tabs_right()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')

  for i = last_tab, current_tab + 1, -1 do
    vim.cmd(i .. 'tabclose')
  end
end

-- Function to close tabs to the left
local function close_tabs_left()
  local current_tab = vim.fn.tabpagenr()

  for i = current_tab - 1, 1, -1 do
    vim.cmd('1tabclose')
  end
end

-- Enhanced keybindings
vim.keymap.set('n', '<leader>tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', '<leader>tL', close_tabs_left, { desc = 'Close tabs to the left' })

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    vim.cmd('bdelete')
  else
    -- If it's the only buffer in tab, close the tab
    vim.cmd('tabclose')
  end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })

-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- Git branch function
local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return "  " .. branch .. " "
  end
  return ""
end

-- File type with icon
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = "[LUA]",
    java = "[JAVA]",
    python = "[PY]",
    javascript = "[JS]",
    html = "[HTML]",
    css = "[CSS]",
    json = "[JSON]",
    markdown = "[MD]",
    vim = "[VIM]",
    sh = "[SH]",
    xml = "[XML]",
  }

  if ft == "" then
    return "  "
  end

  return (icons[ft] or ft)
end

-- Word count for text files
local function word_count()
  local ft = vim.bo.filetype
  if ft == "markdown" or ft == "text" or ft == "tex" then
    local words = vim.fn.wordcount().words
    return "  " .. words .. " words "
  end
  return ""
end

-- File size
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand('%'))
  if size < 0 then return "" end
  if size < 1024 then
    return size .. "B "
  elseif size < 1024 * 1024 then
    return string.format("%.1fK", size / 1024)
  else
    return string.format("%.1fM", size / 1024 / 1024)
  end
end

-- Mode indicators with icons
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",  -- Ctrl-V
    c = "COMMAND",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",  -- Ctrl-S
    R = "REPLACE",
    r = "REPLACE",
    ["!"] = "SHELL",
    t = "TERMINAL"
  }
  return modes[mode] or "  " .. mode:upper()
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
-- local function setup_dynamic_statusline()
--   vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
--     callback = function()
--     vim.opt_local.statusline = table.concat {
--       "  ",
--       "%#StatusLineBold#",
--       "%{v:lua.mode_icon()}",
--       "%#StatusLine#",
--       " │ %f %h%m%r",
--       "%{v:lua.git_branch()}",
--       " │ ",
--       "%{v:lua.file_type()}",
--       " | ",
--       "%{v:lua.file_size()}",
--       "%=",                     -- Right-align everything after this
--       "%l:%c  %P ",             -- Line:Column and Percentage
--     }
--     end
--   })
--   vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })
-- 
--   vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
--     callback = function()
--       vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
--     end
--   })
-- 
--   vim.cmd [[
--     highlight StatusLine guifg=#000000 guibg=#ffff5f
--     highlight StatusLineNC guifg=#bbbbbb guibg=#000080
--   ]]
-- 
-- end
-- 
-- setup_dynamic_statusline()


-- Define highlight groups with bold text for different modes
vim.api.nvim_set_hl(0, "StatusLineNormal", { fg = "#000000", bg = "#ffff5f", bold = true })
vim.api.nvim_set_hl(0, "StatusLineInsert", { fg = "#000000", bg = "#00ff00", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisual", { fg = "#000000", bg = "#ff00ff", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisualLine", { fg = "#FFFFFF", bg = "#800080", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisualBlock", { fg = "#FFFFFF", bg = "#800080", bold = true })
vim.api.nvim_set_hl(0, "StatusLineReplace", { fg = "#000000", bg = "#ff0000", bold = true })
vim.api.nvim_set_hl(0, "StatusLineCommand", { fg = "#000000", bg = "#00ffff", bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#bbbbbb", bg = "#000080", bold = true })

-- Mode words mapping
local mode_words = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "VISUAL-LINE",
  [""] = "VISUAL-BLOCK",
  r = "REPLACE",
  R = "REPLACE",
  c = "COMMAND",
}

-- Get the current mode's highlight group and text label
local function mode_highlight()
  local mode = vim.fn.mode()
  return (mode_words[mode] and ("%#StatusLine" .. mode_words[mode]:gsub("%-", "") .. "#") or "%#StatusLineNormal#"), mode_words[mode] or ""
end

-- Get current Git branch name (shell call)
local function git_branch()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> /dev/null')
  if handle then
    local branch = handle:read("*l")
    handle:close()
    if branch and #branch > 0 then
      return "git:" .. branch .. " "
    end
  end
  return ""
end

-- Human readable file size
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand("%:p"))
  if size < 0 then return "" end
  if size < 1024 then
    return size .. "B "
  elseif size < 1024 * 1024 then
    return string.format("%.1fKB ", size / 1024)
  else
    return string.format("%.1fMB ", size / (1024 * 1024))
  end
end

-- Return filetype text
local function filetype_word()
  return vim.bo.filetype ~= "" and vim.bo.filetype .. " " or ""
end

-- Return current file encoding, default utf-8
local function file_encoding()
  local enc = vim.bo.fileencoding
  if enc == "" then enc = "utf-8" end
  return enc .. " "
end

-- Return vi-compatible file format (unix/dos/mac)
local function file_format()
  return vim.bo.fileformat .. " "
end

-- Get basic diagnostics counts (errors and warnings)
local function diagnostics_count()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local result = ""
  if errors > 0 then
    result = result .. "E:" .. errors .. " "
  end
  if warnings > 0 then
    result = result .. "W:" .. warnings .. " "
  end
  return result
end

-- Build the statusline string dynamically
local function statusline()
  local hl, mode_text = mode_highlight()
  local branch = git_branch()
  local size = file_size()
  local ft = filetype_word()
  local enc = file_encoding()
  local fmt = file_format()
  local diag = diagnostics_count()

  return table.concat {
    hl, " ", mode_text, " ",
    branch,
    "%f ",  -- filename with relative path
--    ft,
    size,
    enc,
--    fmt,
    diag,
    "%m%r", -- modified, readonly flags
    "%=",
    "Ln %l/%L, Col %c ",
    "%#StatusLine#", -- reset highlight
  }
end

-- Make the statusline function globally callable by vim
_G.statusline_func = statusline

-- Configure Neovim to use this statusline function
vim.o.statusline = "%!v:lua.statusline_func()"
vim.o.laststatus = 2


-- omni completion menu 
vim.cmd [[highlight Pmenu      guibg=#33332e guifg=#fefecd]]     -- dark sand background, light tan text
vim.cmd [[highlight PmenuSel   guibg=#ba7e42 guifg=#000000]]     -- golden brown select, black text
vim.cmd [[highlight PmenuSbar  guibg=#77674a]]                   -- muted brown scrollbar
vim.cmd [[highlight PmenuThumb guibg=#fecd82]]                   -- light sand scrollbar handle
vim.cmd [[highlight ErrorMsg guibg=#ffeeaa guifg=#800000]]     -- pale yellow background, dark red text
vim.cmd [[highlight WarningMsg guibg=#fff3c0 guifg=#ba7e42]]   -- light tan back, golden brown text
