local api = vim.api

return {
  require('plugins.statusline'),
  
  'kshenoy/vim-signature',
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'debugloop/telescope-undo.nvim',
  {
    'rcarriga/nvim-notify',
    config = function()
        vim.notify = require("notify")
    end
  },
  {
    'DanilaMihailov/beacon.nvim',
    enabled = function()
        return vim.g.neovide == nil
    end,
  },
  { 'willothy/flatten.nvim', config = true },
  {
      'pocco81/true-zen.nvim',
      opts = {
        integrations = {
            twilight = true,
        },
      },
      config = function()
          api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
          api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
          api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
          api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
          api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})
      end,
  },
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
  {
    'folke/twilight.nvim',
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>X", "<cmd>Twilight<CR>", {noremap = true, silent = true})
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
    'j-hui/fidget.nvim',
    opts = {
      progress = {
        display = {
          render_limit = 4,
        },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
        require'gitsigns'.setup()
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
}
