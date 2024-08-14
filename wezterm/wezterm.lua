local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}
config.max_fps = 80

config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

-- config.color_scheme = 'Monokai Pro Ristretto (Gogh)'
config.color_scheme = 'Monokai Pro (Gogh)'

config.scrollback_lines = 10000

return config

