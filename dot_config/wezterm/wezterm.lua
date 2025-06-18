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

-- Performance optimizations
config.max_fps = 120
config.animation_fps = 60
config.cursor_blink_rate = 800

-- WSL integration (automatically detect and use WSL)
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Debian'
  config.wsl_domains = {
    {
      name = 'WSL:Debian',
      distribution = 'Debian',
      username = 'kozak',
      default_cwd = '/home/kozak',
    },
  }
end

-- Useful key bindings (simplified, no leader key)
config.keys = {
  -- Split panes
  { key = 'd', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'r', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Navigate panes
  { key = 'h', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  
  -- Close pane
  { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  
  -- Tab management
  { key = 't', mods = 'ALT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'ALT', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'ALT', action = wezterm.action.ActivateTabRelative(-1) },
  
  -- Quick split for editing
  { 
    key = 'a', 
    mods = 'ALT', 
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    }
  },
  
  -- Copy/Paste (keep standard bindings)
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  
  -- Scrollback (keep standard bindings)
  { key = 'PageUp', mods = 'SHIFT', action = wezterm.action.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollByPage(1) },
}

-- Mouse bindings for better copy/paste
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

return config