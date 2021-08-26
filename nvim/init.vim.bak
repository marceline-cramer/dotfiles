set completeopt=menuone,noselect

call plug#begin()

" Color scheme
" TODO: find more schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'folke/tokyonight.nvim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Startup screen
Plug 'mhinz/vim-startify'

" i3 config syntax highlighting
Plug 'mboughaba/i3config.vim'

" File browser
Plug 'preservim/nerdtree'

" ???
Plug 'universal-ctags/ctags'

" Highlights trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Various language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Hex color code preview
" Plug 'ap/vim-css-color'
" Plug 'gko/vim-coloresque'
" Plug 'RRethy/vim-hexokinase'

" IDE features (autocomplete, language server, info)
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Git diffs in side
Plug 'airblade/vim-gitgutter'

" Semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Plug 'neovim/nvim-lsp'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" TODO: research?
" Plug 'junegunn/fzf.vim'

" Plug 'kosayoda/nvim-lightbulb'

" TODO: research?
" Plug 'hrsh7th/nvim-compe'

" Plug 'liuchengxu/vim-which-key'

" TODO: bind to a key
Plug 'sbdchd/neoformat'

call plug#end()

" Theme
" colorscheme palenight
let g:tokyonight_style='night'
colorscheme tokyonight

" Status bar
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Always show git signs
set signcolumn=yes

" Neovide configuration
let g:neovide_refresh_rate=90
let g:neovide_cursor_vfx_mode="wireframe"

" Position in code
set number
set ruler

" Margin line at 81 characters
set colorcolumn=81

" Split new panels to the right
set splitright

" Ignore case of searches
set ignorecase

