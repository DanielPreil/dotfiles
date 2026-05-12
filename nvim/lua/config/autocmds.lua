local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("formatoptions"),
	callback = function()
		vim.opt_local.formatoptions:remove({ "t", "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
	group = augroup("unsupported_files"),
	pattern = {
		"*.doc",
		"*.docx",
		"*.xls",
		"*.xlsx",
		"*.ppt",
		"*.pptx",
		"*.odt",
		"*.ods",
		"*.odp",
		"*.pages",
		"*.numbers",
		"*.key",
		"*.pdf",
	},
	callback = function(event)
		local name = vim.fn.fnamemodify(event.file, ":t")
		vim.schedule(function()
			if vim.api.nvim_get_current_buf() == event.buf then
				vim.cmd.enew()
			end
			pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			vim.notify(("Megnyitás blokkolva: %s"):format(name), vim.log.levels.WARN)
		end)
	end,
})
