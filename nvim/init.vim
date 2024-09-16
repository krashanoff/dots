" krashanoff
"

" Important pages:
" - exclusive

" plugins
lua require('newinit')

" hot reload
nnoremap <silent><leader>src :source ~/.config/nvim/init.vim<cr>

" ez edit
nnoremap <silent><leader>ini :e ~/.config/nvim/init.vim<cr>
nnoremap <silent><leader>inv :e ~/.config/nvim/init.vim<cr>
nnoremap <silent><leader>inl :e ~/.config/nvim/lua/newinit.lua<cr>

" base configuration help
if !exists('g:syntax-on')
    syntax on
end
set formatoptions+=o    " Continue comment marker in new lines.

" Automatically toggle between absolute and hybrid line numbering schemes.
" Use absolute when in insert mode, hybrid when in normal mode, and
" absolute when we begin inputting some command.
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
set wrap
set list

set cc=+1
hi ColorColumn ctermbg=lightgrey guibg=lightgrey

set splitbelow                  " Horizontal split below current.
set splitright                  " Vertical split to right of current.

let &shortmess = 'filnxtToOFI'
let &showbreak = '\'
set hidden
set nowritebackup

" break at the word
set breakindent
set formatoptions=l
set lbr

let g:github_colors_soft = 1
let g:github_colors_block_diffmark = 0

" I dont always like pressing shift, but sometimes it's
" a necessary evil
nnoremap q<leader> q:
inoremap <S-BS> <C-w>

" enter is good
inoremap <silent><S-CR> <ESC>O

" undo shortcuts
inoremap <silent><C-z> <ESC>ua
nnoremap <silent><C-z> u

" change line endings
command MakeLF :%s/\r//g
command MakeCRLF :%s/\n/\r\n/g

" emacs did a few things right tbh
inoremap <silent><C-a> <ESC>0i
inoremap <silent><C-e> <ESC>$a

" quickly delete a bunch of stuff
inoremap <silent><A-BS> <ESC>dvb
nnoremap <silent><A-BS> dvb
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
nnoremap <silent><leader>O :only<cr>

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
inoremap <silent><leader>o <ESC>o
inoremap <silent><leader>O <ESC>O

nnoremap <silent><leader>l :nohl<cr>
nnoremap <silent><leader>r :set relativenumber!<cr>
inoremap <silent><leader>r <ESC>:set relativenumber!<cr>a
nnoremap <silent><leader>r :set relativenumber!<cr>
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
" nnoremap <silent>q<leader> q: " this is kind of a dangerous mapping since it
" overlaps with macro stuff.

" easy end-of-file
nnoremap <silent><leader>E G$
nnoremap go gg

" moving lines
nnoremap <silent><A-j> :m+<cr>==
nnoremap <silent><A-k> :m-2<cr>==
" osx key moment when in non-standard terminal
if exists("g:neovide")
  nnoremap <silent>∆ :m+<cr>== 
  nnoremap <silent>˚ :m-2<cr>==
endif
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

" window manipulation
inoremap <M-S-H> <C-w>H
inoremap <M-S-J> <C-w>J
inoremap <M-S-K> <C-w>K
inoremap <M-S-L> <C-w>L
tnoremap <M-S-H> <C-\><C-n><C-w>H
tnoremap <M-S-J> <C-\><C-n><C-w>J
tnoremap <M-S-K> <C-\><C-n><C-w>K
tnoremap <M-S-L> <C-\><C-n><C-w>L
nnoremap <M-S-H> <C-w>H
nnoremap <M-S-J> <C-w>J
nnoremap <M-S-K> <C-w>K
nnoremap <M-S-L> <C-w>L

" More natural splits
nnoremap <silent><leader>v <esc>:vsplit<cr>
nnoremap <silent><leader>h <esc>:split<cr>
nnoremap <silent><leader>Ww <C-w>+
nnoremap <silent><leader>Wa <C-w><
nnoremap <silent><leader>Ws <C-w>-
nnoremap <silent><leader>Wd <C-w>>
nnoremap <silent><leader>Wq <C-w>=

" tab manipulation
nnoremap <silent><leader>tn :tabnew<cr>
nnoremap <silent><leader>tc :tabclose<cr>
nnoremap <silent><leader>ts :tab split<cr>
nnoremap <silent><M-h> :tabp<cr>
nnoremap <silent><M-;> :tabp<cr>
nnoremap <silent><M-l> :tabn<cr>
nnoremap <silent><M-'> :tabn<cr>

" Make the terminal better.
tnoremap <leader><leader> <c-\><c-n>

autocmd TermOpen * setlocal statusline=%{b:term_title}

nnoremap <silent><leader>tt :ter<cr>
nnoremap <silent><leader>tv :vsplit<cr>:ter<cr>
nnoremap <silent><leader>th :split<cr>:ter<cr>

" fuzzy find remaps
nnoremap <leader>ff <cmd>Telescope fd<cr>
nnoremap <leader>fF <cmd>Telescope find_files find_command=fd,--hidden,--unrestricted<cr>
nnoremap <leader>frg <cmd>Telescope live_grep<cr>
nnoremap <leader>fgc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>fgS <cmd>Telescope git_stash<cr>
nnoremap <leader>fws <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fds <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fdd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fkm <cmd>Telescope keymaps<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr><esc>
nnoremap <leader>fb <cmd>Telescope buffers<cr><esc>
" press esc after to ensure we just browse marks.
nnoremap <leader>fm <cmd>Telescope marks<cr><esc>
nnoremap <leader>fM <cmd>Telescope man_pages<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fu <cmd>Telescope undo<cr>
nnoremap <leader>fnn <cmd>Telescope notify<cr>
nnoremap <leader>fnl <cmd>Telescope neorg find_linkable<cr>
nnoremap <leader>fnh <cmd>Telescope neorg search_headings<cr>

inoremap <leader>de <ESC>dea

if exists("g:beacon")
  nnoremap <silent><leader>B :Beacon<cr>
endif

" debug
nnoremap <silent><leader>dbb :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <silent><leader>dbc :lua require'dap'.continue()<cr>
nnoremap <silent><leader>dbso :lua require'dap'.step_over()<cr>
nnoremap <silent><leader>dbsi :lua require'dap'.step_into()<cr>
nnoremap <silent><leader>dbii :lua require'dap'.repl.open()<cr>

" neovide stuff :)
if exists("g:neovide")
    nnoremap <D-c> "+yy
    inoremap <D-c> <ESC>"+yya
    nnoremap <D-v> "+p
    inoremap <D-v> <ESC>"+pa
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_refresh_rate = 60
    let g:neovide_refresh_rate_idle = 5
    let g:neovide_input_macos_alt_is_meta = v:true
endif

