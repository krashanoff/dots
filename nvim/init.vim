"
" krashanoff
"
" A simple, uncomplicated Neovim setup.
"

" better leader
let mapleader = ";"

call plug#begin('~/.config/nvim/plugged')
    " colors and aesthetics
    Plug 'cormacrelf/vim-colors-github'
    Plug 'ajmwagar/vim-deus'
    Plug 'altercation/vim-colors-solarized'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'folke/twilight.nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'vim-airline/vim-airline'

    " general qol
    Plug 'preservim/nerdcommenter'
    Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-fugitive'

    " virgin nerdtree v. chad chadtree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }

    " fuzzy find
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " completion, language analysis, linting
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'dense-analysis/ale'

    " tags, navigation
    Plug 'liuchengxu/vista.vim'

    " completely unnecessary
    Plug 'justinmk/vim-sneak'
    Plug 'psliwka/vim-smoothie'
call plug#end()

" setup twilight and color schemes
set background=dark
let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 0
colorscheme deus

" airline
let g:airline#extensions#tabline#enabled = 1

lua << EOF
  require("twilight").setup {
  }
  require("zen-mode").setup {
  }
EOF

" telescope remaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr><esc>
nnoremap <leader>fm <cmd>Telescope marks<cr><esc> " press esc after to ensure we just browse marks.
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>

" generic telescope commands
nnoremap <leader>ts :Telescope 

nnoremap <silent><leader>n :new<cr>

syntax on
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set modeline            " Enable modeline.
set number relativenumber
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.
set noerrorbells                " No beeps
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set autoindent
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab " indent with spaces.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" hot reload
:nnoremap <silent><leader>src :source $HOME/.config/nvim/init.vim<cr>

""""""""
" CORE "
""""""""
let &shortmess = 'filnxtToOFI'
let &showbreak = '\'
" TODO: Set the SHADA properly. set shada = '2000,f1,<500'
set hidden
set nowritebackup

nnoremap <silent><leader>L :nohl<cr>
nnoremap <silent><leader>w :w<cr>

""""""""""""
" MOVEMENT "
""""""""""""
:nnoremap GG G$ " easy end-of-file
nnoremap " TODO: mapping for going to the end of a line.
nnoremap go :<c-u>echo "count is " . v:count<cr>

" moving lines
nnoremap <silent><A-j> :m+<cr>==
nnoremap <silent><A-k> :m-2<cr>==
" osx key moment
" nnoremap <silent>∆ :m+<cr>== 
" nnoremap <silent>˚ :m-2<cr>==
vnoremap <silent><A-j> :m '>+1<cr>gv=gv
vnoremap <silent><A-k> :m '<-2<cr>gv=gv

" movement from within insert mode
inoremap <silent><C-h> <ESC>h i
inoremap <silent><C-j> <ESC>j i
inoremap <silent><C-k> <ESC>k i
inoremap <silent><C-l> <ESC>l i

inoremap <silent><Leader><Leader> <ESC> " break out of insert ez
tnoremap <silent><Leader><Leader> <ESC>
inoremap <Leader>w <ESC>:up<cr>a
nnoremap <Leader>w :up<cr>
nnoremap w :up<cr>

" window switching
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" tab creation
:inoremap <silent><leader>t <Esc>:tabnew<cr>
:nnoremap <silent><leader>t :tabnew<cr>
:nnoremap <silent><C-w>t :tabnew<cr>

" terminal ease-of-use
:autocmd TermOpen * setlocal statusline=%{b:term_title}
:tnoremap <Esc> <C-\><C-n>

" CHADtree
:nnoremap <silent><leader>T :CHADopen<cr>

""""""""""""""""
" OTHER CONFIGS "
""""""""""""""""
" source completion.vim
" source nav.vim
" source neovide.vim

