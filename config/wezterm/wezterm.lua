-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("MesloLGS NF")

-- and finally, return the configuration to wezterm
return config
