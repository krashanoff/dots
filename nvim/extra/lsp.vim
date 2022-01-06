"
" LSP functionality
"

call plug#begin(g:plug_directory)
    " Base
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Maintained fork of:
    " Plug 'glepnir/lspsaga.nvim'
    Plug 'tami5/lspsaga.nvim'
    
    " Rust
    Plug 'simrat39/rust-tools.nvim'

    " Go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

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