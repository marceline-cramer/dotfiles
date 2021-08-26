local api = vim.api
local fn = vim.fn
local g = vim.g
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

require('packer').startup(function()
  --[[
    Plugins left to find and configure:
      - startup screen (vim-startify)
      - i3 config syntax highlighting (mboughaba/i3config.vim)
      - ctags...? (universal-ctags/ctags)
      - trailing whitespace highlighter (ntpeters/vim-better-whitespace)
      - polyglot (sheerun/vim-polyglot)
      - git diffs (airblade/vim-gitgutter, lewis6991/gitsigns.nvim)
      - formatter (liuchengxu/vim-which-key)
  ]]--

  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'mattn/emmet-vim'
  use 'folke/tokyonight.nvim'

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lspconfig')
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine')
    end
  }

  use {
    -- TODO: replace with hrsh7th/nvim-cmp
    'hrsh7th/nvim-compe',
    config = function()
      require('plugins.completion')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.filetree')
    end
  }

  use {
    'onsails/lspkind-nvim',
    config = function()
      require('plugins.lspkind')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }
end)
