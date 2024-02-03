local wezterm = require "wezterm"
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = "OneHalfDark"
config.font = wezterm.font "FiraCode Nerd Font"
config.font_size = 8.0
config.keys = {
  { key = '-', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '0', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '1', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '2', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '3', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '4', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '5', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '6', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '7', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '8', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '9', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '=', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'c', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'f', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'k', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'm', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'n', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'q', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'r', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 't', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'v', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = 'w', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '{', mods = 'SUPER', action = act.DisableDefaultAssignment },
  { key = '}', mods = 'SUPER', action = act.DisableDefaultAssignment },
}
config.window_background_opacity = 0.8
return config
