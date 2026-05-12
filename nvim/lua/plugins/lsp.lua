return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.inlay_hints = opts.inlay_hints or {}
			opts.inlay_hints.enabled = false

			opts.folds = opts.folds or {}
			opts.folds.enabled = false

			opts.codelens = opts.codelens or {}
			opts.codelens.enabled = false

			opts.servers = opts.servers or {}
			opts.servers["*"] = opts.servers["*"] or {}
			opts.servers["*"].keys = opts.servers["*"].keys or {}

			local function disable_key(lhs)
				for _, key in ipairs(opts.servers["*"].keys) do
					if type(key) == "table" and key[1] == lhs then
						key[2] = false
						return
					end
				end
				table.insert(opts.servers["*"].keys, { lhs, false })
			end

			disable_key("<leader>cc")
			disable_key("<leader>cC")

			opts.servers.cssls = opts.servers.cssls or {}
			opts.servers.emmet_language_server = opts.servers.emmet_language_server or {}
			opts.servers.html = opts.servers.html or {}

			if opts.servers.vtsls then
				opts.servers.vtsls.single_file_support = false
			end
		end,
	},
}
