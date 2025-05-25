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

-- Leader key configuration
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Useful key bindings
config.keys = {
  -- Split panes (using leader key)
  { key = 'd', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'r', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- Navigate panes (using leader key)
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  
  -- Close pane (using leader key)
  { key = 'w', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  
  -- Tab management (using leader key)
  { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  
  -- AI Chat with CopilotChat
  { 
    key = 'a', 
    mods = 'LEADER', 
    action = wezterm.action.SplitPane {
      direction = 'Right',
      command = { args = { 'nvim', '-c', 'CopilotChatToggle' } },
      size = { Percent = 40 },
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