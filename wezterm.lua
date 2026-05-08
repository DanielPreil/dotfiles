local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Vesper"

config.front_end = "OpenGL"
-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

config.initial_cols = 170
config.initial_rows = 42

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.mouse_wheel_scrolls_tabs = false
config.alternate_buffer_wheel_scroll_speed = 1

config.font_size = 19
config.window_padding = { bottom = 2 }
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.font = wezterm.font("Lilex")

config.colors = {
	tab_bar = {
		background = "#000000",
		active_tab = {
			bg_color = "#000000",
			fg_color = "#ffffff",
		},
		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#aaaaaa",
		},
		inactive_tab_hover = {
			bg_color = "#000000",
			fg_color = "#ffffff",
		},
	},
}

config.keys = {
	{ key = "h", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },

	{ key = "h", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "l", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },

	-- Option+j / Option+k továbbítása Neovim felé Meta+j / Meta+k-ként
	{ key = "j", mods = "ALT", action = wezterm.action.SendString("\x1bj") },
	{ key = "k", mods = "ALT", action = wezterm.action.SendString("\x1bk") },

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
