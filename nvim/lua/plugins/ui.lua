local shared = require("utils.path")
local theme = require("utils.theme")

return {
	{
		"LazyVim/LazyVim",
		init = function()
			theme.setup_autosave()
		end,
		opts = {
			colorscheme = theme.load_saved,
		},
	},

	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},

	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				hover = {
					enabled = true,
					silent = true,
				},
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						find = "No information available",
					},
					opts = { skip = true },
				},
			},
			presets = {
				lsp_doc_border = true,
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.options = opts.options or {}
			opts.options.section_separators = { left = "", right = "" }
			opts.options.component_separators = { left = "", right = "" }

			local x = opts.sections and opts.sections.lualine_x or nil
			if not x or #x < 2 then
				return
			end

			if #x >= 3 then
				table.remove(x, 3)
			end

			x[2] = {
				function()
					local ok, noice = pcall(require, "noice")
					if not ok or not noice.api.status.command.has() then
						return ""
					end
					local cmd = noice.api.status.command.get()
					local len = vim.fn.strchars(cmd)
					if len <= 2 then
						return cmd
					end
					return vim.fn.strcharpart(cmd, len - 2, 2)
				end,
				cond = function()
					return package.loaded["noice"] and require("noice").api.status.command.has()
				end,
				color = function()
					return { fg = Snacks.util.color("Statement") }
				end,
				padding = { left = 1, right = 1 },
			}
		end,
	},

	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			opts.win = opts.win or {}
			opts.win.no_overlap = false
			opts.layout = opts.layout or {}
			opts.layout.height = {
				min = 4,
				max = 25,
			}
			return opts
		end,
	},

	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			opts.indent = { enabled = false }
			opts.words = { enabled = false }
			opts.explorer = opts.explorer or {}
			opts.explorer.replace_netrw = true

			opts.dashboard = opts.dashboard or {}
			opts.dashboard.preset = opts.dashboard.preset or {}
			opts.dashboard.preset.header = table.concat({
				"• ▌ ▄ ·.  ▄▄▄·  ▄· ▄▌    ▄▄▄▄▄ ▄ .▄▄▄▄ .    ·▄▄▄      ▄▄▄   ▄▄· ▄▄▄ .",
				"·██ ▐███▪▐█ ▀█ ▐█▪██▌    •██  ██▪▐█▀▄.▀·    ▐▄▄·▪     ▀▄ █·▐█ ▌▪▀▄.▀·",
				"▐█ ▌▐▌▐█·▄█▀▀█ ▐█▌▐█▪     ▐█.▪██▀▐█▐▀▀▪▄    ██▪  ▄█▀▄ ▐▀▀▄ ██ ▄▄▐▀▀▪▄",
				"██ ██▌▐█▌▐█ ▪▐▌ ▐█▀·.     ▐█▌·██▌▐▀▐█▄▄▌    ██▌.▐█▌.▐▌▐█•█▌▐███▌▐█▄▄▌",
				"▀▀  █▪▀▀▀ ▀  ▀   ▀ •      ▀▀▀ ▀▀▀ · ▀▀▀     ▀▀▀  ▀█▄▀▪.▀  ▀·▀▀▀  ▀▀▀ ",
				"        ▄▄▄▄· ▄▄▄ .    ▄▄▌ ▐ ▄▌▪  ▄▄▄▄▄ ▄ .▄     ▄· ▄▌      ▄• ▄▌    ",
				"        ▐█ ▀█▪▀▄.▀·    ██· █▌▐███ •██  ██▪▐█    ▐█▪██▌▪     █▪██▌    ",
				"        ▐█▀▀█▄▐▀▀▪▄    ██▪▐█▐▐▌▐█· ▐█.▪██▀▐█    ▐█▌▐█▪ ▄█▀▄ █▌▐█▌    ",
				"        ██▄▪▐█▐█▄▄▌    ▐█▌██▐█▌▐█▌ ▐█▌·██▌▐▀     ▐█▀·.▐█▌.▐▌▐█▄█▌    ",
				"        ·▀▀▀▀  ▀▀▀      ▀▀▀▀ ▀▪▀▀▀ ▀▀▀ ▀▀▀ ·      ▀ •  ▀█▄▀▪ ▀▀▀     ",
			}, "\n")

			opts.picker = opts.picker or {}
			opts.picker.actions = opts.picker.actions or {}
			opts.picker.sources = opts.picker.sources or {}
			opts.picker.sources.explorer = opts.picker.sources.explorer or {}
			opts.picker.sources.explorer.win = opts.picker.sources.explorer.win or {}
			opts.picker.sources.explorer.win.list = opts.picker.sources.explorer.win.list or {}
			opts.picker.sources.explorer.win.list.keys = opts.picker.sources.explorer.win.list.keys or {}
			opts.picker.sources.explorer.win.list.keys["Y"] = {
				"yank_project_path",
				mode = { "n" },
				desc = "Copy Path to Clipboard",
			}

			opts.picker.actions.yank_project_path = function(_, item)
				local path = item and item.file or nil
				if not path or path == "" then
					return
				end
				shared.copy_path_to_clipboard(path, "Explorer path copied")
			end
		end,
	},
}
