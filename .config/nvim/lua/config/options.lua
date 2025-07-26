-- ~/.config/nvim/lua/options.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set the default border for all floating windows
vim.opt.winborder = "rounded"

vim.opt.termguicolors = true

-- Relative and absolute line numbers combined
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Cursor line
vim.opt.cursorline = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitution
vim.opt.inccommand = "split"

-- Text wrapping
vim.opt.wrap = true
vim.opt.breakindent = true

-- Tabstops
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Save undo history
vim.opt.undofile = true

-- Add other options as needed

