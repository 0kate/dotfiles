local wezterm = require 'wezterm'
local config = {}

config.colors = {
  cursor_bg = '#999999',
}
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.debug_key_events = true
config.default_cursor_style = 'BlinkingBlock'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.keys = {
  {
    key = 'f',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bf',
  },
  {
    key = 'b',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = 'x',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bx',
  },
}
config.line_height = 1.1
config.window_decorations = 'RESIZE'
config.window_padding = {
  top = 1,
  right = 1,
  left = 1,
  bottom = 1,
}

return config
