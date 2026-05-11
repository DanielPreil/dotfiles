local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ── Rendering ────────────────────────────────────────────────
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- M2 Air 120Hz Liquid Retina kijelzőhöz
config.max_fps = 120
config.animation_fps = 1 -- animáció minimalizálva (kurzor blink stb.) → kevesebb overhead

-- ── Input ─────────────────────────────────────────────────────
config.use_ime = false -- IME pipeline kikapcs → alacsonyabb input latency

-- ── Font ──────────────────────────────────────────────────────
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- ── Megjelenés ────────────────────────────────────────────────
config.color_scheme = "Vesper"
config.window_padding = { bottom = 2 }
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- ── Tab bar ───────────────────────────────────────────────────
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- ── Ablak ─────────────────────────────────────────────────────
config.initial_cols = 170
config.initial_rows = 42

-- ── Scroll ────────────────────────────────────────────────────
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.mouse_wheel_scrolls_tabs = false
config.alternate_buffer_wheel_scroll_speed = 1

-- ── Alt billentyűk ────────────────────────────────────────────
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- ── Színek ────────────────────────────────────────────────────
config.colors = {
	tab_bar = {
		background = "#000000",
		active_tab = { bg_color = "#000000", fg_color = "#ffffff" },
		inactive_tab = { bg_color = "#000000", fg_color = "#aaaaaa" },
		inactive_tab_hover = { bg_color = "#000000", fg_color = "#ffffff" },
	},
}

-- ── Keybindings ───────────────────────────────────────────────
config.keys = {
	{ key = "h", mods = "CMD",       action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD",       action = wezterm.action.ActivateTabRelative(1) },
	{ key = "h", mods = "ALT",       action = wezterm.action.MoveTabRelative(-1) },
	{ key = "l", mods = "ALT",       action = wezterm.action.MoveTabRelative(1) },
	{ key = "j", mods = "ALT",       action = wezterm.action.SendString("\x1bj") },
	{ key = "k", mods = "ALT",       action = wezterm.action.SendString("\x1bk") },
	{ key = "d", mods = "ALT",       action = wezterm.action.SendString("\x1bd") },
	{ key = "d", mods = "ALT|SHIFT", action = wezterm.action.SendString("\x1bD") },
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

-- ── Startup ───────────────────────────────────────────────────
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	tab:set_title("dev")
	pane:set_title("dev")
	window:gui_window():maximize()
end)

return config
