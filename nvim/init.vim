call plug#begin()

" Color scheme
Plug 'folke/tokyonight.nvim'

" Status bar
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Various language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Improved syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Autocompletion framework for built-in LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'

call plug#end()

" Theme
let g:tokyonight_style='night'
colorscheme tokyonight

" Syntax highlighting
syntax enable
filetype plugin indent on

" Position in code
set number
set ruler

" Margin line at 81 characters
set colorcolumn=81

" Always show diagnostics
set signcolumn=yes

" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Configure lualine
lua <<EOF
local lualine = require 'lualine'
lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'', ''},
    section_separators = {'', ''},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = {
          hint = '  ',
        },
        sections = { 'error', 'warn', 'info', 'hint' },
      },
      'progress',
    },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' }
  }
})
EOF

" Configure nvim-cmp
lua <<EOF
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'buffer' },
  },
})
EOF

" Configure LSP
lua <<EOF
local lspconfig = require 'lspconfig'

local function on_attach(client)
end

-- Enable rust_analyzer
lspconfig.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = true,
		update_in_insert = true,
	}
)
EOF
