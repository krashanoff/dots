"
" krashanoff
"
" Organization does not exist.
"

" better leader
let mapleader = ";"

let g:plug_directory = "~/.config/nvim/plugged"

call plug#begin(g:plug_directory)
    " colors and aesthetics
    Plug 'ajmwagar/vim-deus'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'morhetz/gruvbox'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'itchyny/lightline.vim'

    " general qol
    Plug 'preservim/nerdcommenter'
    " Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-fugitive'
    Plug 'folke/which-key.nvim'

    " virgin nerdtree v. chad chadtree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }

    " fuzzy find
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/telescope.nvim'

    " LSP stuff
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

    " Maintained fork of:
    " Plug 'glepnir/lspsaga.nvim'
    Plug 'tami5/lspsaga.nvim'
    
    " Rust
    Plug 'simrat39/rust-tools.nvim'

    " Go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " absolutely unnecessary
    " Plug 'psliwka/vim-smoothie'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'folke/zen-mode.nvim'
call plug#end()

" mapping hud
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

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
let g:airline_section_z = '%2p%% ≡ %l/%L : %c'

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

"
" LSP
"

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Format on write with a timeout of 500.
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 500)

set updatetime=200
set timeoutlen=500

" Show diagnostic popup on cursor hold
autocmd CursorHold * Lspsaga show_line_diagnostics

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Lspsaga stuff (if enabled)
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent>gx :Lspsaga code_action<cr>
nnoremap <silent>gr :Lspsaga rename<cr>
nnoremap <silent>gd :Lspsaga preview_definition<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent>[e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>]e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" lspsaga
lua <<EOF
local saga = require('lspsaga')
local config = {
    use_saga_diagnostic_sign = false,
}
saga.init_lsp_saga(config)
EOF

" Rust LSP
lua <<EOF
local nvim_lsp = require('lspconfig')

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Completion settings.
lua << EOF
   local cmp = require('cmp')
   local cmp_opts = {
     snippet = {
       expand = function(args)
         -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
         -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
       end,
     },
     mapping = {
       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
       ['<C-f>'] = cmp.mapping.scroll_docs(4),
       ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
       ['<c-tab>'] = cmp.mapping.complete(),
       ['<C-e>'] = cmp.mapping.close(),
       ['<c-space>'] = cmp.mapping.confirm({ select = true }),
     },
     sources = cmp.config.sources({
       { name = 'nvim_lsp' },
     }, {
       { name = 'buffer' },
     }),
   }
   cmp.setup(cmp_opts)
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
inoremap <silent><C-z> <ESC>ua
nnoremap <silent><C-z> u

" word delete
inoremap <silent><A-bspc> <C-w>

" scratch buffers
nnoremap <silent><leader>N :new<cr>

if !exists('g:syntax-on')
    syntax on
end
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
if exists('g:lightline')
    set noshowmode " mode is already shown by lightline.
else
    set showmode
end
set modeline    " Enable modeline.

" Automatically toggle between absolute and hybrid line numbering schemes.
" Use absolute when in insert mode, hybrid when in normal mode, and
" absolute when we begin inputting some command.
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

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

" try to load a session in the current directory, if there
" is one.
nnoremap <silent><leader>S :source ./Session.vim<cr>

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
inoremap <silent><leader>e <ESC>e
inoremap <silent><leader>w <ESC>w
inoremap <silent><leader>b <ESC>b

nnoremap <silent><leader>l :nohl<cr>
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>r <ESC>:set relativenumber!<cr>a
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>z <ESC>zzi
nnoremap <silent><leader>z zz
vnoremap <silent><leader>r <ESC>:set relativenumber!<cr>

inoremap <silent><leader><return> ;<return>

" cancel operator pending with tab.
onoremap <silent><Tab> <ESC>

" deleting, killing and switching between buffers.
" NOTE: trying to kill buffer number 1 will kill the buffer you are sitting
" on. This is because the v:count1 variable defaults to 1 when a mapping is
" fired.
nnoremap <silent><expr> , ':b' . v:count1 . '<cr>'
nnoremap <silent><expr> <leader>!b ':bd!' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
nnoremap <silent><expr> <leader>b ':bd' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
tnoremap <silent><expr> <leader>!b ':bd!' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
tnoremap <silent><expr> <leader>b ':bd' . (v:count1 != 1 ? v:count1 : "") . '<cr>'

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
inoremap <leader>w <ESC>:up<cr>
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
nnoremap <silent><leader>Ww <C-w>+
nnoremap <silent><leader>Wa <C-w><
nnoremap <silent><leader>Ws <C-w>-
nnoremap <silent><leader>Wd <C-w>>
nnoremap <silent><leader>Wq <C-w>=

" tab creation
nnoremap <silent><leader>tn :tabnew<cr>
nnoremap <silent><leader>tc :tabclose<cr>

" terminal ease-of-use
autocmd TermOpen * setlocal statusline=%{b:term_title}
nnoremap <silent><leader>tt :ter<cr>
nnoremap <silent><leader>tv :vsplit<cr>:ter<cr>
nnoremap <silent><leader>th :split<cr>:ter<cr>
tnoremap <esc> <c-\><c-n>
tnoremap <leader><leader> <c-\><c-n>

" CHADtree
nnoremap <silent><leader>T :CHADopen<cr>

