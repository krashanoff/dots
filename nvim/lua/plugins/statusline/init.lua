return {
  'glepnir/galaxyline.nvim',
  branch = 'main',
  config = function()
      require('plugins.statusline.config')
  end,

  -- Use newer devicons
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}
