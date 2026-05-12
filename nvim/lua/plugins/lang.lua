return {
	{
		"brenoprata10/nvim-highlight-colors",
		ft = {
			"css",
			"scss",
			"sass",
			"less",
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"astro",
			"svelte",
		},
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			virtual_symbol_position = "inline",
			enable_named_colors = true,
			enable_tailwind = true,
			exclude_buffer = function(bufnr)
				local name = vim.api.nvim_buf_get_name(bufnr)
				if name == "" then
					return false
				end
				local ok, stat = pcall(vim.uv.fs_stat, name)
				return ok and stat and stat.size and stat.size > 200 * 1024 or false
			end,
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		opts = {
			file_types = { "markdown" },
		},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"xml",
			"javascriptreact",
			"typescriptreact",
			"javascript",
			"typescript",
			"vue",
			"svelte",
			"astro",
		},
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local ensure = {
				"css",
				"scss",
			}
			opts.ensure_installed = opts.ensure_installed or {}
			local seen = {}
			for _, parser in ipairs(opts.ensure_installed) do
				seen[parser] = true
			end
			for _, parser in ipairs(ensure) do
				if not seen[parser] then
					table.insert(opts.ensure_installed, parser)
					seen[parser] = true
				end
			end
		end,
	},
}
