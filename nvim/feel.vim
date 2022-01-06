"
" feel
"
" Should be sourced last.
"

call plug#begin(g:plug_directory)
    " colors and aesthetics
    Plug 'ajmwagar/vim-deus'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'morhetz/gruvbox'

    " Smoother, easier
    " Plug 'psliwka/vim-smoothie'
    " Plug 'junegunn/limelight.vim'
    " Plug 'folke/zen-mode.nvim'
    Plug 'junegunn/goyo.vim'
call plug#end()

let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 0
colorscheme PaperColor

" goyo config
nnoremap <silent><leader>Z :Goyo<cr>
