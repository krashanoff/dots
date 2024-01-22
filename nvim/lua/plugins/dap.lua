return {
  {
      'mfussenegger/nvim-dap',
      event = "VeryLazy",
  },
  {
      'theHamsta/nvim-dap-virtual-text',
      event = "VeryLazy",
  },
  {
      'rcarriga/nvim-dap-ui',
      event = "VeryLazy",
      dependencies = {
        'mfussenegger/nvim-dap',
        'leoluz/nvim-dap-go',
      },
      config = function()
          local dap = require('dap')

          dap.adapters.go = function(callback, config)
            -- Wait for delve to start
            vim.defer_fn(function()
                callback({type = "server", host = "127.0.0.1", port = "port"})
              end,
            100)
          end
      end,
  },

  -- This one behaves strangely
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
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
  
  -- Still workin on this
  --
  -- {
  --     'williamboman/mason.nvim',
  --     config = function (self, opts)
  --       require("mason").setup()
  --     end,
  -- },
  -- {
  --     'williamboman/mason-lspconfig.nvim',
  --     dependencies = {
  --         'williamboman/mason.nvim',
  --         'neovim/nvim-lspconfig',
  --     },
  --     config = function()
  --       require("mason-lspconfig").setup()

  --       require("mason-lspconfig").setup {
  --           ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "golangci_lint_ls" },
  --       }
  --     end,
  -- },
}
