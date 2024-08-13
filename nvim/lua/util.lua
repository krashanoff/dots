local M = {}

local constants = require'constants'

local keymap = vim.keymap.set

M.keymap = keymap

-- Map a sequence to start from the leader key.
M.mapl = function (modes, suffix, action, opts)
  return keymap(modes, constants.LEADER .. suffix, action, opts)
end

-- Map a sequence to start from the secondary leader key.
M.mapl2 = function (modes, suffix, action, opts)
  return keymap(modes, constants.SECONDARY_LEADER .. suffix, action, opts)
end

-- Map a sequence to start from both the leader and secondary leader keys.
M.mapboth = function (modes, suffix, action, opts)
  M.mapl(modes, suffix, action, opts)
  M.mapl2(modes, suffix, action, opts)
end

return M

