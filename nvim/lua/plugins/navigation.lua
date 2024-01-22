-- Anything related to finding files.

local api = vim.api
local keymap = vim.keymap.set

return {
  {
    'wfxr/minimap.vim',
    config = function()
        api.nvim_set_keymap("n", "<leader>M", ":MinimapToggle<CR>", {})
        api.nvim_set_keymap("i", "<leader>M", "<ESC>:MinimapToggle<CR>", {})
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
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
            local nvim_tree_api = require'nvim-tree.api'
            nvim_tree_api.tree.toggle({
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
      keymap("n", "K", "<Plug>(CybuPrev)")
      keymap("n", "J", "<Plug>(CybuNext)")
      -- vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
      keymap({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")
    end
  },
}
