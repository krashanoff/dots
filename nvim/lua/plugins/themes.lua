local api = vim.api

return {
  'sainnhe/everforest',
  'EdenEast/nightfox.nvim',
  'rebelot/kanagawa.nvim',
  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_dim_inactive_windows = true
      vim.g.sonokai_show_eob = true
    end,
  },
  {
    'catppuccin/nvim',
    name = "catppuccin",
    dependencies = {
        'lewis6991/gitsigns.nvim',
    },
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
}