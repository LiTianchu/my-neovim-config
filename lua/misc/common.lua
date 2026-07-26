-- Set mapleader before loading any plugins or settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.titlestring = "%{getcwd()}"
vim.o.title = true
vim.o.splitbelow = true

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Normal Mode
-- Cusor line
vim.opt.cursorline = true

-- No Wrap
vim.opt.wrap = false

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Allow copy pasting with system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Enable mouse
vim.opt.mouse:append("a")

-- Case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Aesthetics
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Tabs
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 4 -- indent width (4 spaces)
vim.opt.tabstop = 4 -- tab display width

-- Scroll offset
if vim.g.neovide then
	vim.o.scrolloff = 0
else
	vim.o.scrolloff = 5
end
