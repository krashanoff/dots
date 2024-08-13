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
    tag = '0.1.5',
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

        keymap('n', '<leader>fs', ":Telescope lsp_document_symbols<CR>", {})
        keymap('n', '<leader>fS', ":Telescope lsp_workspace_symbols<CR>", {})
    end,
  },

  -- I used this after it was recommended in place of nvim-tree due to some weird
  -- issues on Windows.
  {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-tree/nvim-web-devicons',
          'MunifTanjim/nui.nvim',
          '3rd/image.nvim',
      },
      config = function ()
          keymap('n', '<leader>T', ':Neotree toggle<CR>', {})
          keymap('n', 'gf', ':Neotree toggle<CR>', {})
          keymap('n', 'gB', ':Neotree toggle buffers<CR>', {})
      end,
  },

  {
    'ghillb/cybu.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    config = function()
      local cybu = require 'cybu'
      cybu.setup({
          display_time = 500,
      })
      keymap("n", "<C-K>", "<Plug>(CybuPrev)")
      keymap("n", "<C-J>", "<Plug>(CybuNext)")
      keymap({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
      keymap({"n", "v"}, "<c-tab>", "<plug>(CybuLastusedNext)")
    end
  },
}
