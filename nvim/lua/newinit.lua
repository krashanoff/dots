-- lua moment

local PLUGINS_MODULE = "plugins"

-- Remove netrw, we use plugins instead.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Need to have 24-bit color enabled so the UI isn't a nightmare tbh
if os.getenv("TERM") == "xterm-256color" then
    vim.opt.termguicolors = true
end
vim.g.background = 'dark'

local constants = require'constants'
vim.g.mapleader = constants.LEADER

local util = require'util'
local keymap = util.keymap
local mapl = util.mapl
local mapl2 = util.mapl2
local mapboth = util.mapboth

-- Cancel operations with tab.
keymap('o', '<tab>', '<esc>', {})

-- IntelliJ sort of convinced me that space is a good leader,
-- so there are a few keymaps where I use space out of habit.
mapboth('n', 'w', ':w<CR>', {})
mapl2('n', 'l', ':Lazy<cr>', {})

--
--Base
--
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.textwidth = 0
vim.opt.modeline = true
vim.opt.number = true

-- Partial mouse support only
vim.opt.mouse = 'nv'
vim.opt.mousemodel = 'extend'

-- The terminal escape pattern is kind of confusing, so use <leader><leader> instead.
-- I used to bind <ESC> directly to this, but Lazygit likes to use it for its cancel
-- operations.
keymap('t', '<leader><leader>', '<C-\\><C-n>', {})

-- It's nice to be able to leader-cmd when we use colon.
mapl('n', 'xx', ':x<CR>', {})

-- Delete a buffer.
mapl('n', 'xb', ':bdel<CR>', {})

-- Statusline things
require'statusline'()

-- Register lua stuff for the langauge server.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Initialize all the plugins
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
require('lazy').setup(PLUGINS_MODULE)

