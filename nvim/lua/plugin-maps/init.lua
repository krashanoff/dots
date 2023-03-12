local M = {}

local requirefn = function(path)
    return function()
        return require(path)
    end
end

M.ufo = requirefn("ufo")
M.lspsaga = requirefn("lspsaga")
M.lspconfig = requirefn("lspconfig")

return M
