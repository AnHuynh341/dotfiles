local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    "JetBrainsMono Nerd Font",
    "Fira Code",
    "monospace",
  },

  keys = {
    {
  key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("Clipboard"),
    },
  },

  font_size = 12,
  color_scheme = "Dracula", -- Or "Dracula", "Gruvbox Dark", etc.
  colors = {
    background = "#000025",  -- override just the background
  },
  window_background_opacity = 0.95,  -- 1.0 is fully opaque, 0.0 is fully transparent
  enable_tab_bar = false,           -- Hide tabs if you prefer a clean look
  use_fancy_tab_bar = false,
  hide_mouse_cursor_when_typing = false,

  window_padding = {
    left = 8,
    right = 8,
    top = 6,
    bottom = 6,
  },

  default_prog = { "zsh", "-l" },

  enable_wayland = true,

}

