local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    "JetBrainsMono Nerd Font",
    "SpaceMono Nerd Font Mono",
    "Fira Code",
  },

  keys = {
    {
  key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("Clipboard"),
    },
  },

  font_size = 12,
  color_scheme = "Dracula", --"Dracula"/"Gruvbox Dark"
  colors = {
    background = "#000025",  -- override just the background
  },
  window_background_opacity = 0.80,  -- 1.0 = fully opaque
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  hide_mouse_cursor_when_typing = true,

  window_padding = {
    left = 8,
    right = 8,
    top = 6,
    bottom = 6,
  },

  default_prog = { "zsh", "-l" },

  enable_wayland = true,

}

