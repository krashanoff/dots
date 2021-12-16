"
" krashanoff
"
" Organization does not exist.
"

" better leader
let mapleader = ";"

call plug#begin('~/.config/nvim/plugged')
    " colors and aesthetics
    Plug 'ajmwagar/vim-deus'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'morhetz/gruvbox'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'itchyny/lightline.vim'

    " general qol
    Plug 'preservim/nerdcommenter'
    Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-fugitive'

    " virgin nerdtree v. chad chadtree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }

    " fuzzy find
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/telescope.nvim'

    " LSP stuff
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'hrsh7th/cmp-nvim-lsp'
    " Plug 'hrsh7th/cmp-buffer'
    " Plug 'hrsh7th/nvim-cmp'
    " Plug 'onsails/lspkind-nvim'
    Plug 'liuchengxu/vista.vim'

    " absolutely unnecessary
    " Plug 'psliwka/vim-smoothie'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'folke/zen-mode.nvim'
call plug#end()

set guifont=FiraCode\ Nerd\ Font:h14

" setup color schemes
set background=dark
let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 0
colorscheme PaperColor

" statusline configuration

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_y = '0x%B | [%{&fenc=="" ? &enc : &fenc}%{exists("+bomb") && &bomb ? " B":""}]'
let g:airline_section_z = '%2p%% ≡ %l / %L : %c'

" lightline, if I'm using it
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \ },
      \ 'component_function': {
      \   'mode': 'Mode',
      \ },
      \ }

function! Mode()
    return &filetype ==# 'TelescopePrompt' ? 'TEL' :
        \ lightline#mode()
endfunction

"
" GUI options
"

" neovide options
let g:neovide_refresh_rate = 60
let g:neovide_fullscreen = v:true
let g:neovide_input_use_logo = v:true

" goyo config
nnoremap <silent><leader>G :Goyo<cr>

lua << EOF
 -- Set up LSP stuff.
--   local lspkind = require('lspkind')
--   local cmp = require('cmp')
--   cmp.setup {
--     snippet = {
--       expand = function(args)
--         -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--         -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--       end,
--     },
--     mapping = {
--       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-Space>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.close(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     },
--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       -- { name = 'vsnip' }, -- For vsnip users.
--       -- { name = 'luasnip' }, -- For luasnip users.
--       -- { name = 'ultisnips' }, -- For ultisnips users.
--       -- { name = 'snippy' }, -- For snippy users.
--     }, {
--       { name = 'buffer' },
--     }),
--     formatting = {
--         format = lspkind.cmp_format({with_text = false, maxwidth = 50})
--     }
--   }
EOF

" fuzzy find remaps
nnoremap <leader>ff <cmd>Telescope fd<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr><esc>
nnoremap <leader>fb <cmd>Telescope buffers<cr><esc>
nnoremap <leader>fm <cmd>Telescope marks<cr><esc> " press esc after to ensure we just browse marks.
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" undo
noremap <silent><C-z> <ESC>ua
nnoremap <silent><C-z> u

nnoremap <silent><leader>n :new<cr>

if !exists('g:syntax-on')
    syntax on
end
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
if exists('g:lightline')
    set noshowmode  " lightline thing.
else
    set showmode
end
set modeline    " Enable modeline.

" Automatically toggle between absolute and hybrid line numbering schemes.
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
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
nnoremap <silent><leader>src :source ~/.config/nvim/init.vim<cr>

" ez edit
nnoremap <silent><leader>ini :e ~/.config/nvim/init.vim<cr>

""""""""
" CORE "
""""""""
let &shortmess = 'filnxtToOFI'
let &showbreak = '\'
set hidden
set nowritebackup

" autocmd! VimLeave * mksession! ~/Session.vim
" autocmd! VimEnter * source ~/Session.vim

" TODO: remap ' to input register for command.

" try to load a session in the current directory, if there
" is one.
nnoremap <silent><leader>S source ./Session.vim

" adjust window layout
nnoremap <silent>= <C-w>=
nnoremap <silent>- <C-w>-
nnoremap <silent>+ <C-w>+
nnoremap <silent>< <C-w><
nnoremap <silent>> <C-w>>

" cycle buffers
nnoremap <silent><leader>n :bn<cr>
nnoremap <silent><leader>p :bp<cr>

" break out of insert with movement
" also allow this movement in normal mode
" TODO: allow contextual movement. If only on single buffer,
" then motion, else move between windows.
inoremap <silent><C-l> <ESC>l
inoremap <silent><C-k> <ESC>k
inoremap <silent><C-j> <ESC>j
inoremap <silent><C-h> <ESC>h
inoremap <silent><leader>l <ESC>l
inoremap <silent><leader>k <ESC>k
inoremap <silent><leader>j <ESC>j
inoremap <silent><leader>h <ESC>h
nnoremap <silent><C-l> l
nnoremap <silent><C-k> k
nnoremap <silent><C-j> j
nnoremap <silent><C-h> h
inoremap <silent><leader>$ <ESC>$
inoremap <silent><leader>0 <ESC>0

nnoremap <silent><leader>l :nohl<cr>
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>r <ESC>:set relativenumber!<cr>a
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>z <ESC>zzi
nnoremap <silent><leader>z zz
inoremap <leader>: <ESC>:
vnoremap <silent><leader>r <ESC>:set relativenumber!<cr>

" cancel operator pending with tab.
onoremap <silent><Tab> <ESC>

" deleting, killing and switching between buffers.
nnoremap <silent><expr> <leader>b ':bd' . v:count1 . '<C-M>'
nnoremap <silent><expr> , ':b' . v:count1 . '<C-M>'

" deleting, killing, and switching between windows.
nnoremap <silent><leader>q :q<cr>

""""""""""""
" MOVEMENT "
""""""""""""
nnoremap <silent><leader>E G$ " easy end-of-file
nnoremap go :<c-u>echo "count is " . v:count<cr>

" moving lines
nnoremap <silent><A-j> :m+<cr>==
nnoremap <silent><A-k> :m-2<cr>==
" osx key moment
" nnoremap <silent>∆ :m+<cr>== 
" nnoremap <silent>˚ :m-2<cr>==
vnoremap <silent><A-j> :m '>+1<cr>gv=gv
vnoremap <silent><A-k> :m '<-2<cr>gv=gv

inoremap <silent><leader><leader> <ESC> " break out of insert ez
inoremap <leader>W <ESC>:up<cr>
inoremap <leader>w <ESC>:up<cr>
nnoremap <leader>W :up<cr>
nnoremap <leader>w :up<cr>

" window switching
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
nnoremap <silent><leader>v <esc>:vsplit<cr>
nnoremap <silent><leader>h <esc>:split<cr>
nnoremap <silent><leader>ww <C-w>+
nnoremap <silent><leader>wa <C-w><
nnoremap <silent><leader>ws <C-w>-
nnoremap <silent><leader>wd <C-w>>
nnoremap <silent><leader>wq <C-w>=

" tab creation
nnoremap <silent><leader>tn :tabnew<cr>
nnoremap <silent><leader>tc :tabclose<cr>

" terminal ease-of-use
autocmd TermOpen * setlocal statusline=%{b:term_title}
nnoremap <silent><leader>tt :ter<cr>
nnoremap <silent><leader>tv :vsplit<cr>:ter<cr>
nnoremap <silent><leader>th :split<cr>:ter<cr>
tnoremap <Esc> <C-\><C-n>

" CHADtree
nnoremap <silent><leader>T :CHADopen<cr>

