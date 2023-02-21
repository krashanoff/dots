
" krashanoff
"

" Better leader and sane defaults
let mapleader = ";"
inoremap <silent><leader><return> ;<return>

" Disable mouse
set mouse=

" Cancel operations with tab.
onoremap <silent><Tab> <ESC>

" hot reload
nnoremap <silent><leader>src :source ~/.config/nvim/init.vim<cr>

" ez edit
nnoremap <silent><leader>ini :e ~/.config/nvim/init.vim<cr>

exec 'source ' . $XDG_CONFIG_HOME . '/nvim/base.vim'

" plugins
lua require('plugins')

let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 0
colorscheme sonokai

" goyo config
nnoremap <silent><leader>Z :Goyo<cr>
nnoremap <silent><leader>L :Limelight!!<cr>

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
inoremap <silent><leader>l <ESC>l
inoremap <silent><leader>k <ESC>k
inoremap <silent><leader>j <ESC>j
inoremap <silent><leader>h <ESC>h
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
inoremap <C-l> <C-\><C-n><C-w>l
inoremap <C-k> <C-\><C-n><C-w>k
inoremap <C-j> <C-\><C-n><C-w>j
inoremap <C-h> <C-\><C-n><C-w>h
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
nnoremap <leader>fG <cmd>Telescope live_grep<cr>
nnoremap <leader>fgc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgS <cmd>Telescope git_stash<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr><esc>
nnoremap <leader>fb <cmd>Telescope buffers<cr><esc>
" press esc after to ensure we just browse marks.
nnoremap <leader>fm <cmd>Telescope marks<cr><esc>
nnoremap <leader>fM <cmd>Telescope man_pages<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent><leader>T :NvimTreeToggle<cr>

