local wezterm = require 'wezterm'
local keys = require 'keys'

local config = wezterm.config_builder()
print('hi')
config.font = wezterm.font('Hack Nerd Font Mono')
--config.color_scheme = 'Kanagawa Dragon (Gogh)'
config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'
config.hide_tab_bar_if_only_one_tab = false
config.default_prog = {'C:/Program Files/Git/bin/bash.exe', '-i', '-l'}
keys.apply_to_config(config)
return config
