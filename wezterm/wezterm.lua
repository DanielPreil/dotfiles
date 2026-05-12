local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower"

config.max_fps = 120
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.check_for_updates = false

config.use_ime = false
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19

config.color_scheme = "Tokyo Night Moon"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 2 }
config.window_background_opacity = 0.94
config.macos_window_background_blur = 12
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.default_prog = { "/bin/zsh" }

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.initial_cols = 170
config.initial_rows = 42

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.mouse_wheel_scrolls_tabs = false
config.alternate_buffer_wheel_scroll_speed = 1

config.colors = {
	background = "#09090b",
	cursor_bg = "#c8c093",
	cursor_border = "#c8c093",
	selection_bg = "#2d4f67",
	selection_fg = "#c8c093",
	tab_bar = {
		background = "#09090b",
		active_tab = { bg_color = "#101014", fg_color = "#ffffff" },
		inactive_tab = { bg_color = "#09090b", fg_color = "#8a8a93" },
		inactive_tab_hover = { bg_color = "#16161d", fg_color = "#ffffff" },
	},
}

config.keys = {
	{ key = "h", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "h", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "l", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					local tab = window:active_tab()
					tab:set_title(line)
					pane:set_title(line)
				end
			end),
		}),
	},
}

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	tab:set_title("dev")
	pane:set_title("dev")
	window:gui_window():maximize()
end)

return config
