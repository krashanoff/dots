"
" krashanoff
"

" Better leader
let mapleader = ";"
inoremap <silent><leader><return> ;<return>

" Cancel operations with tab.
onoremap <silent><Tab> <ESC>

" Plug directory
let g:plug_directory = "~/.config/nvim/plugged"

" hot reload
nnoremap <silent><leader>src :source ~/.config/nvim/init.vim<cr>

" ez edit
nnoremap <silent><leader>ini :e ~/.config/nvim/init.vim<cr>

" Set up plug
" Run PlugInstall if there are missing plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Load the bare-minimum quality of life plugins for all systems.
call plug#begin(g:plug_directory)
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'kshenoy/vim-signature'
    Plug 'tpope/vim-fugitive'
    Plug 'folke/which-key.nvim'

    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':CHADdeps'}

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/telescope.nvim'

    " colors and aesthetics
    Plug 'ajmwagar/vim-deus'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/sonokai'

    " Smoother, easier
    " Plug 'psliwka/vim-smoothie'
    " Plug 'junegunn/limelight.vim'
    " Plug 'folke/zen-mode.nvim'
    " Plug 'justinmk/vim-sneak'
    Plug 'junegunn/goyo.vim'
call plug#end()

" my leader overrides sneak
" nnoremap : <Plug>Sneak_;

" undo shortcuts
inoremap <silent><C-z> <ESC>ua
nnoremap <silent><C-z> u

" quickly delete a bunch of stuff
inoremap <silent><A-BS> <ESC>db
nnoremap <silent><A-BS> db
inoremap <silent><A-DEL> <ESC>dw
nnoremap <silent><A-BS> dw
inoremap <silent><C-BS> <ESC>d0
nnoremap <silent><C-BS> d0
inoremap <silent><C-DEL> <ESC>d$
nnoremap <silent><C-DEL> d$

" scratch buffers
nnoremap <silent><leader>N :new<cr>

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
inoremap <silent><leader>I <ESC>I
inoremap <silent><leader>A <ESC>A

nnoremap <silent><leader>l :nohl<cr>
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>r <ESC>:set relativenumber!<cr>a
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>z <ESC>zzi
nnoremap <silent><leader>z zz
vnoremap <silent><leader>r <ESC>:set relativenumber!<cr>

" deleting, killing and switching between buffers.
" NOTE: trying to kill buffer number 1 will kill the buffer you are sitting
" on. This is because the v:count1 variable defaults to 1 when a mapping is
" fired.
nnoremap <silent><expr> <leader>!b ':bd!' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
nnoremap <silent><expr> <leader>b ':bd' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
tnoremap <silent><expr> <leader>!b ':bd!' . (v:count1 != 1 ? v:count1 : "") . '<cr>'
tnoremap <silent><expr> <leader>b ':bd' . (v:count1 != 1 ? v:count1 : "") . '<cr>'

" deleting, killing, and switching between windows.
nnoremap <silent><leader>q :q<cr>

" easy end-of-file
nnoremap <silent><leader>E G$
nnoremap go gg

" moving lines
nnoremap <silent><A-j> :m+<cr>==
nnoremap <silent><A-k> :m-2<cr>==
" osx key moment
" nnoremap <silent>∆ :m+<cr>== 
" nnoremap <silent>˚ :m-2<cr>==
vnoremap <silent><A-j> :m '>+1<cr>gv=gv
vnoremap <silent><A-k> :m '<-2<cr>gv=gv

inoremap <silent><leader><leader> <C-\><C-n>
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

" Make the terminal better.
tnoremap <esc> <c-\><c-n>
tnoremap <leader><leader> <c-\><c-n>

autocmd TermOpen * setlocal statusline=%{b:term_title}

nnoremap <silent><leader>tt :ter<cr>
nnoremap <silent><leader>tv :vsplit<cr>:ter<cr>
nnoremap <silent><leader>th :split<cr>:ter<cr>

" fuzzy find remaps
nnoremap <leader>ff <cmd>Telescope fd<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr><esc>
nnoremap <leader>fb <cmd>Telescope buffers<cr><esc>
" press esc after to ensure we just browse marks.
nnoremap <leader>fm <cmd>Telescope marks<cr><esc>
nnoremap <leader>fM <cmd>Telescope man_pages<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" CHADtree
nnoremap <silent><leader>T :CHADopen<cr>

" Load additional configurations.
exec 'source ' . $XDG_CONFIG_HOME . '/nvim/base.vim'
exec 'source ' . $XDG_CONFIG_HOME . '/nvim/feel.vim'
exec 'source ' . $XDG_CONFIG_HOME . '/nvim/statusline.vim'

