local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0
-- config.color_scheme = 'Monokai Pro Ristretto (Gogh)'
config.color_scheme = 'Monokai Pro (Gogh)'

config.scrollback_lines = 10000

-- TODO: remove padding on window when opening neovim.

return config
