set completeopt=menuone,noselect

call plug#begin()

" Color scheme
Plug 'folke/tokyonight.nvim'

" Various language syntax highlighting
Plug 'sheerun/vim-polyglot'

call plug#end()

" Theme
let g:tokyonight_style='night'
colorscheme tokyonight
