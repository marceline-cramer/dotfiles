call plug#begin()

" Color scheme
Plug 'folke/tokyonight.nvim'

" Status bar
Plug 'hoob3rt/lualine.nvim'

" Various language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Formatter
Plug 'sbdchd/neoformat'

" Pairs up brackets, parantheses, etc.
Plug 'jiangmiao/auto-pairs'

" Shows indentation levels
Plug 'lukas-reineke/indent-blankline.nvim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Improved syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Markdown live preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Discord rich presence
Plug 'andweeb/presence.nvim'

" Git modifications in sign column
Plug 'airblade/vim-gitgutter'

" Bench startup times
Plug 'dstein64/vim-startuptime'

" Pretty icons in LSP completion menu
Plug 'onsails/lspkind-nvim'

" Autocompletion framework for built-in LSP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'

" WGSL syntax highlighting
Plug 'DingDean/wgsl.vim'

" Yuck syntax highlighting
Plug 'elkowar/yuck.vim'

" Word use nitpicker
Plug 'reedes/vim-wordy'

" Spellcheck + thesaurus
Plug 'preservim/vim-lexical'

call plug#end()

" Theme
let g:tokyonight_style='night'
colorscheme tokyonight
highlight Normal ctermbg=None
highlight NonText ctermbg=None
highlight SignColumn ctermbg=None
highlight Normal guibg=None
highlight NonText guibg=None
highlight SignColumn guibg=None

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

" Use system clipboard
set clipboard=unnamedplus

" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Firefox-like tab navigation
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

" Activate markdown-preview.nvim for .uml files too
let g:mkdp_filetypes = ['markdown', 'plantuml']

" Configure indent-blankline
lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  -- show_current_context = true,
  -- show_current_context_start = true,
  -- show_end_of_line = true,
}
EOF

" Configure lualine
lua <<EOF
local lualine = require 'lualine'
lualine.setup({
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename' },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = {
          error = ' E',
          warn = ' W',
          info = ' I',
          hint = ' H'
        },
        sections = { 'error', 'warn', 'info', 'hint' },
        colored = true,
        update_in_insert = true,
        always_visible = true,
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
local lspkind = require('lspkind')
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        return vim_item
      end
    })
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp'},
  },
})
EOF

" Configure LSP
lua <<EOF
local lspconfig = require 'lspconfig'

local function on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local setup_parms = {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true
      }
    }
  }
}

lspconfig.clangd.setup(setup_parms)
lspconfig.rust_analyzer.setup(setup_parms)
lspconfig.zls.setup(setup_parms)

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF
