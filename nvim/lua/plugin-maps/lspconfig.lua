lspconfig = require "lspconfig"
util = require "lspconfig/util"

-- Gopls
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

-- Clang
lspconfig.clangd.setup{}

-- Typescript
lspconfig.tsserver.setup{}

-- Python
lspconfig.pyright.setup{}

local api = vim.api
api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

