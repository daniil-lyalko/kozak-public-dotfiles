local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Modern, safe configuration
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Fira Code",
  "Consolas",
})
config.font_size = 12.0
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true

return config