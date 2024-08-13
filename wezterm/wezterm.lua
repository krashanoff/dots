local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0
config.color_scheme = 'Monokai Pro Ristretto (Gogh)'

config.scrollback_lines = 10000

return config
