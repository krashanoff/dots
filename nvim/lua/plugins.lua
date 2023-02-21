-- lua moment

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
  {
        'sainnhe/sonokai',
        lazy = true,
  },
  {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      build = 'require\'statusline\'',

      -- Use newer devicons
      dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
      'lewis6991/gitsigns.nvim',
      config = 'require(\'gitsigns\').setup()',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'kshenoy/vim-signature',
  'tpope/vim-fugitive',
  'folke/which-key.nvim',
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
      end
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
        cybu.setup()
        vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
        vim.keymap.set("n", "J", "<Plug>(CybuNext)")
        vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
        vim.keymap.set({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")
      end
  },
  'junegunn/goyo.vim',
  'junegunn/limelight.vim',
  {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
          require('ufo').setup()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
          }
          local language_servers = require("lspconfig").util.available_servers()
          for _, ls in ipairs(language_servers) do
              require('lspconfig')[ls].setup({
                  capabilities = capabilities
                  -- you can add other fields for setting up lsp server in this table
              })
          end

          vim.o.foldcolumn = '1' -- '0' is not bad
          vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
          vim.o.foldlevelstart = 99
          vim.o.foldenable = true

          -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
          vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
          vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
      local keymap = vim.keymap.set

      -- I'm too lazy to separate things out right now, so LSP config stuff lives here
      keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
      keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>")

      keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
      keymap("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>")
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  },
  {
      'neovim/nvim-lspconfig',
      config = function()
          lspconfig = require "lspconfig"
          util = require "lspconfig/util"

          lspconfig.gopls.setup {
            cmd = {"gopls", "serve"},
            filetypes = {"go", "gomod"},
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
          }

          local api = vim.api
          api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.go',
            callback = function()
              vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
            end
          })
      end
  }
})

