local api = vim.api
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local opt = vim.opt

-- colorscheme
opt.termguicolors = true
opt.background = 'dark'
g.tokyonight_style = 'night'
-- g.tokyonight_transparent = true
cmd [[colorscheme tokyonight]]

-- position
opt.number = true
opt.ruler = true

-- margin line at 81 characters
opt.colorcolumn = '81'

-- split new panels to the right
opt.splitright = true

-- syntax highlighting
opt.syntax = 'true'
cmd [[filetype plugin indent on]]
