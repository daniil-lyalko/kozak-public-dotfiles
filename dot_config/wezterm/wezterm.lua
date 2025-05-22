local wezterm = require 'wezterm'

-- Use the config_builder which helps provide clearer error messages
local config = wezterm.config_builder()

-- Color scheme and appearance
config.color_scheme = 'Lavandula'
-- config.color_scheme = 'Catppuccin Mocha' -- Original scheme commented out
config.window_background_opacity = 0.95
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Menlo', -- Common on macOS
  'Consolas', -- Common on Windows
  -- Add more fallbacks if needed, e.g., 'DejaVu Sans Mono', 'Noto Mono'
}
config.font_size = 14.0
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

return config