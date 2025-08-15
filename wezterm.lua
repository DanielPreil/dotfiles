-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config = {
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	font = wezterm.font("0xProto Nerd Font"),
	font_size = 19,
	window_background_opacity = 0.8,
	window_padding = { bottom = 1 },
	macos_window_background_blur = 10,
	-- Control Option/Alt key behavior
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,

	window_background_gradient = {
		colors = {
			"hsl(220 90% 2%)",
			"hsl(220 90% 5%)",
			"hsl(220 90% 8%)",
			"hsl(220 90% 4%)",
		},
		orientation = { Linear = { angle = 45.0 } },
		blend = "Rgb",
	},

	colors = {
		tab_bar = {
			background = "hsl(200 100% 3%)",
			active_tab = {
				bg_color = "hsl(220 80% 7%)",
				fg_color = "#ffffff",
			},
			inactive_tab = {
				bg_color = "hsl(200 100% 3%)",
				fg_color = "#aaaaaa",
			},
			inactive_tab_hover = {
				bg_color = "hsl(210 90% 5%)",
				fg_color = "#ffffff",
			},
		},
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
					-- Also set the pane title to prevent overrides
					pane:set_title(line)
				end
			end),
		}),
	},
}

return config
