call plug#begin()

" Color scheme
Plug 'folke/tokyonight.nvim'

" Various language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

call plug#end()

" Theme
let g:tokyonight_style='night'
colorscheme tokyonight

" Syntax highlighting
syntax enable
filetype plugin indent on

" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Configure LSP
lua <<EOF
local lspconfig = require 'lspconfig'

local function on_attach(client)
  require 'completion'.on_attach(client)
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
