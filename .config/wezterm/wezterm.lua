local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Ayu Mirage (Gogh)'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.debug_key_events = true
config.default_cursor_style = 'BlinkingBlock'
config.enable_scroll_bar = false
config.font = wezterm.font_with_fallback({
  { family = 'Hack Nerd Font' },
  { family = 'Hack Nerd Font', assume_emoji_presentation = true },
})
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
config.line_height = 1.2
config.underline_position = -2
config.underline_thickness = 2
config.use_ime = true
config.window_decorations = 'RESIZE'
config.window_padding = {
  top = 0,
  right = 0,
  left = 0,
  bottom = 0,
}

return config
