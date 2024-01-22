-- lua moment

local PLUGINS_MODULE = "plugins"

-- Remove netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = vim.api
local keymap = vim.keymap.set

-- It's nice to be able to leader-cmd when we use colon.
keymap('n', '<leader>x', ':x<CR>', {})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Need to have 24-bit color enabled
if os.getenv("TERM") == "xterm-256color" then
    vim.opt.termguicolors = true
end

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
