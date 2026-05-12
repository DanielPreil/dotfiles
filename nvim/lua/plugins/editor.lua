return {
	{
		"nvim-mini/mini.ai",
		enabled = false,
	},

	{
		"nvim-mini/mini.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.miniindentscope_disable = true
		end,
		config = function()
			local indentscope = require("mini.indentscope")

			indentscope.setup({
				draw = {
					animation = indentscope.gen_animation.none(),
				},
				mappings = {
					object_scope = "ii",
					object_scope_with_border = "ai",
					goto_top = "",
					goto_bottom = "",
				},
				options = {
					border = "both",
					indent_at_cursor = false,
					try_as_border = true,
				},
			})
		end,
	},

	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccPick", "CccConvert" },
		keys = {
			{ "<leader>up", "<cmd>CccPick<cr>", desc = "Color Picker" },
		},
		opts = {},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon Add",
			},
			{
				"<leader>hh",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Harpoon Menu",
			},
			{
				"<leader>h1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon 1",
			},
			{
				"<leader>h2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon 2",
			},
			{
				"<leader>h3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon 3",
			},
			{
				"<leader>h4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon 4",
			},
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = "LazyFile",
		opts = {},
	},
}
