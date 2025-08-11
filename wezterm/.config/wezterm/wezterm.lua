-- Pull in WezTerm API
local wezterm = require("wezterm")

-- Utility functions
local window_background_opacity = 0.9
local function toggle_window_background_opacity(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end
wezterm.on("toggle-window-background-opacity", toggle_window_background_opacity)

local function toggle_ligatures(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end
wezterm.on("toggle-ligatures", toggle_ligatures)

-- Returns color scheme dependant on operating system theme setting (dark/light)
local function color_scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Monokai (dark) (terminal.sexy)"
	else
		return "Monokai (light) (terminal.sexy)"
	end
end

-- Initialize actual config
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Start tmux when opening WezTerm
config.default_prog = { "/bin/zsh", "-l", "-c", "--", "tmux new -As base" }

-- Skip closing confirmation when tmux is running
config.skip_close_confirmation_for_processes_named = { "tmux" }

-- Appearance
config.colors = config.colors or {}
config.colors.background = "#181818"
config.font = wezterm.font({
	-- family = "MesloLGS Nerd Font Mono",
	-- family = "JetBrainsMono Nerd Font Mono",
	family = "Hack Nerd Font Mono",
	weight = "DemiBold",
})
config.font_size = 14.0
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance())
config.window_background_opacity = window_background_opacity
config.macos_window_background_blur = 15
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false
config.use_fancy_tab_bar = false
config.initial_rows = 50
config.initial_cols = 180

-- Keybindings
-- Make Option/Alt produce the layout-composed character (e.g. { })
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
-- (Optional) lets macOS handle higher-level input
config.use_ime = true

-- Return config to WezTerm
return config
