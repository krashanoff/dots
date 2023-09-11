-- lua moment

-- Remove netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local keymap = vim.keymap.set

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Need to have 24-bit color enabled
if os.getenv("TERM") ~= "xterm-256color" then
    vim.opt.termguicolors = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  'kshenoy/vim-signature',
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'mfussenegger/nvim-dap',
  'junegunn/goyo.vim',
  'junegunn/limelight.vim',
  'sainnhe/sonokai',
  {
      'akinsho/toggleterm.nvim',
      config = function()
          local Terminal  = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new({
              cmd = "lazygit",
              hidden = true,
              direction = "float",
          })

          function _lazygit_toggle()
            lazygit:toggle()
          end

          vim.api.nvim_set_keymap("n", "<leader>G", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
      end,
  },
  -- Themes
  {
      'chriskempson/base16-vim'
  },
  'vim-scripts/fu',
  'junegunn/seoul256.vim',
  {
      'sainnhe/sonokai',
      config = function()
        vim.g.sonokai_dim_inactive_windows = true
        vim.g.sonokai_show_eob = true
      end,
  },
  'nvim-neorg/neorg-telescope',
  {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
          require'hop'.setup()
      end,
      init = function()
          local hop = require('hop')

          vim.keymap.set('', 's', function()
              hop.hint_words()
              -- hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = false })
          end, {remap=true})
          -- vim.keymap.set('', 'S', function()
          --     hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = false })
          -- end, {remap=true})
      end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
          triggers_blacklist = {
              i = { "<leader>" },
          },
      })
    end,
  },
  { 'willothy/flatten.nvim', config = true },
  --{
  --      'Equilibris/nx.nvim',
  --      dependencies = { 'nvim-telescope/telescope.nvim' },
  --      config = function()
  --          require('nx').setup({})
  --      end,
  --      lazy = true,
  --},
  "rebelot/kanagawa.nvim",
  {
      'DanilaMihailov/beacon.nvim',
      enabled = function()
          return vim.g.neovide == nil
      end,
  },
  {
      'rcarriga/nvim-notify',
      config = function()
          vim.notify = require("notify")
      end
  },
  {
      'catppuccin/nvim',
      name = "catppuccin",
      cond = function() return vim.g.neovide ~= nil end,
      config = function()
          require('catppuccin').setup({
              flavour = 'mocha',
              background = {
                  light = 'latte',
                  dark = 'mocha',
              },
              styles = {
                  comments = { 'italic' },
              },
              integrations = {
                  gitsigns = true,
                  beacon = true,
                  --neogit = true,
                  gitgutter = true,
                  which_key = true,
                  nvimtree = true,
                  telescope = true,
                  hop = true,
                  lsp_saga = true,
              },
          })
      end,
  },
  {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    config = function()
        require('telescope').setup({
            extensions = {
                undo = {
                    use_delta = true,
                },
            },
        })
        require("telescope").load_extension("undo")
    end,
  },
  {
      "debugloop/telescope-undo.nvim",
  },
  {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function()
          require('statusline')
      end,

      -- Use newer devicons
      dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
      'lewis6991/gitsigns.nvim',
      config = function()
          require'gitsigns'.setup()
      end,
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
          require('lspconfig')[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end
      require('ufo').setup()

      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end,
  },
  {
      'hrsh7th/nvim-cmp',
      dependencies = {
          'neovim/nvim-lspconfig',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-nvim-lsp',

          -- Snippets bleh
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip'
      },
      config = function()
          local cmp = require('cmp')
          cmp.setup({
              snippet = {
                  expand = function(args)
                      require('luasnip').lsp_expand(args.body)
                  end,
              },
              window = {
                  --completion = cmp.config.window.bordered(),
                  --documentation = cmp.config.window.bordered(),
              },
              mapping = cmp.mapping.preset.insert({
                  ["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                  ["<C-u>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                  ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                  ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm(),
              }),
              sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
              }, {
                  { name = 'buffer' },
              })
          })

          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          -- We do Rust through rust-tools.

          -- Gopls
          lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd = {"gopls", "serve"},
            filetypes = {"go", "gomod"},
            root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
          }

          -- Clang
          lspconfig.clangd.setup({ capabilities = capabilities })

          -- Typescript
          lspconfig.tsserver.setup({ capabilities = capabilities })

          -- Python
          lspconfig.pyright.setup({ capabilities = capabilities })

          -- Lua
          lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                  Lua = {
                      runtime = {
                          version = 'LuaJIT',
                      },
                      diagnostics = {
                          globals = {'vim'},
                      },
                      workspace = {
                          library = vim.api.nvim_get_runtime_file("", true),
                      },
                      telemetry = {
                          enable = false,
                      },
                  },
              },
          })
      end,
      },

  --        local api = vim.api
  --        api.nvim_create_autocmd('BufWritePre', {
  --          pattern = '*.go',
  --          callback = function()
  --            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  --          end
  --        })
  --    end,
  --},
  {
      'ms-jpq/coq.artifacts',
      branch = 'artifacts',
  },
  {
      'ms-jpq/coq.thirdparty',
      branch = '3p',
  },
  {
      'nvim-tree/nvim-tree.lua',
      tag = 'nightly',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          require('nvim-tree').setup({
              view = {
                  width = 30,
              },
              renderer = {
                  group_empty = true,
              },
              git = {
                  ignore = false,
              },
          })
      end,
      init = function ()
          keymap('n', '<leader>T', function()
              local api = require'nvim-tree.api'
              api.tree.toggle({
                  ['find_file'] = true,
              })
          end)
      end,
  },
  {
      'ghillb/cybu.nvim',
      branch = 'main',
      dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
      config = function()
        local ok, cybu = pcall(require, 'cybu')
        if not ok then
            return
        end
        cybu.setup({
            display_time = 500,
        })
        vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
        vim.keymap.set("n", "J", "<Plug>(CybuNext)")
        -- vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
        vim.keymap.set({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")
      end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})

      -- LSP finder - Find the symbol's definition
      -- If there is no definition, it will instead be hidden
      -- When you use an action in finder like "open vsplit",
      -- you can use <C-t> to jump back
      keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

      -- Code action
      keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

      -- Rename all occurrences of the hovered word for the entire file
      -- keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

      -- Rename all occurrences of the hovered word for the selected files
      keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

      -- Peek definition
      -- You can edit the file containing the definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

      -- Go to definition
      keymap("n","gD", "<cmd>Lspsaga goto_definition<CR>")

      -- Peek type definition
      -- You can edit the file containing the type definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

      -- Go to type definition
      keymap("n","gT", "<cmd>Lspsaga goto_type_definition<CR>")


      -- Show line diagnostics
      -- You can pass argument ++unfocus to
      -- unfocus the show_line_diagnostics floating window
      keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

      -- Show cursor diagnostics
      -- Like show_line_diagnostics, it supports passing the ++unfocus argument
      keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

      -- Show buffer diagnostics
      keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

      -- Diagnostic jump
      -- You can use <C-o> to jump back to your previous location
      keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

      -- Diagnostic jump with filters such as only jumping to an error
      keymap("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end)
      keymap("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end)

      -- Toggle outline
      keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

      -- If you want to keep the hover window in the top right hand corner,
      -- you can pass the ++keep argument
      -- Note that if you use hover with ++keep, pressing this key again will
      -- close the hover window. If you want to jump to the hover window
      -- you should use the wincmd command "<C-w>w"
      keymap("n", "t", "<cmd>Lspsaga hover_doc<CR>")
      keymap("n", "T", "<cmd>Lspsaga hover_doc ++keep<CR>")

      -- Call hierarchy
      keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

     -- Floating terminal
      keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

      -- Finder (super handy!!!!)
      keymap({"n", "i"}, "<leader>F", "<cmd>Lspsaga lsp_finder<cr>")
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  },
  {
      'simrat39/rust-tools.nvim',
      dependencies = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim' },
      config = function()
          local rt = require'rust-tools'
          rt.setup({
            server = {
              on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
              end,
            },
          })
      end,
  },
  {
      'neovim/nvim-lspconfig',
  },
  {
      'j-hui/fidget.nvim',
      branch = 'legacy',
      config = function()
          require'fidget'.setup()
      end,
  },
})

