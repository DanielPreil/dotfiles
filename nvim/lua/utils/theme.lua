local M = {}

local state_file = vim.fn.stdpath("state") .. "/last_colorscheme.txt"
local state_dir = vim.fn.fnamemodify(state_file, ":h")
local default_theme = "tokyonight-moon"
local save_delay = 150

local preferred = {
	"tokyonight-moon",
	"tokyonight-storm",
	"tokyonight-night",
	"habamax",
	"wildcharm",
}

local function current()
	return vim.g.colors_name
end

function M.read_saved()
	local ok, lines = pcall(vim.fn.readfile, state_file)
	if not ok or not lines or #lines == 0 then
		return default_theme
	end
	local name = vim.trim(lines[1] or "")
	if name == "" then
		return default_theme
	end
	return name
end

function M.save(name)
	if type(name) ~= "string" or name == "" then
		return
	end
	if name == M.read_saved() then
		return
	end
	if vim.fn.isdirectory(state_dir) == 0 then
		pcall(vim.fn.mkdir, state_dir, "p")
	end
	pcall(vim.fn.writefile, { name }, state_file)
end

function M.save_current()
	local name = current()
	if type(name) == "string" and name ~= "" then
		M.save(name)
	end
end

function M.load_saved()
	local saved = M.read_saved()
	if pcall(vim.cmd.colorscheme, saved) then
		return
	end
	if saved ~= default_theme and pcall(vim.cmd.colorscheme, default_theme) then
		M.save(default_theme)
		return
	end
	vim.cmd.colorscheme("habamax")
	M.save("habamax")
end

function M.setup_autosave()
	local group = vim.api.nvim_create_augroup("user_theme_persist", { clear = true })
	local generation = 0

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			M.apply_transparency()
			generation = generation + 1
			local my_generation = generation

			vim.defer_fn(function()
				if my_generation == generation then
					M.save_current()
				end
			end, save_delay)
		end,
	})

	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		callback = M.apply_transparency,
	})
end

function M.apply_transparency()
	local transparent_groups = {
		"Normal",
		"NormalNC",
		"SignColumn",
		"EndOfBuffer",
		"LineNr",
		"LineNrAbove",
		"LineNrBelow",
		"FoldColumn",
		"CursorLineNr",
		"NormalFloat",
		"FloatBorder",
		"Whitespace",
	}

	for _, group in ipairs(transparent_groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
		hl = ok and hl or {}
		hl.bg = nil
		hl.ctermbg = nil
		vim.api.nvim_set_hl(0, group, hl)
	end

	local accent
	for _, group in ipairs({ "Statement", "Function", "Identifier", "Special" }) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
		if ok and hl and hl.fg then
			accent = hl.fg
			break
		end
	end

	if accent then
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = accent, bg = "NONE", ctermbg = "NONE", bold = true })
	end
end

function M.cycle(step)
	local installed = {}
	for _, name in ipairs(vim.fn.getcompletion("", "color")) do
		installed[name] = true
	end

	local list = {}
	for _, name in ipairs(preferred) do
		if installed[name] then
			list[#list + 1] = name
		end
	end
	if #list == 0 then
		list = vim.fn.getcompletion("", "color")
	end
	if #list == 0 then
		return
	end

	local name = current() or list[1]
	local index = 1
	for i, item in ipairs(list) do
		if item == name then
			index = i
			break
		end
	end

	local dir = step or 1
	local next_index = ((index - 1 + dir) % #list) + 1
	if not pcall(vim.cmd.colorscheme, list[next_index]) then
		vim.notify(("Colorscheme not available: %s"):format(list[next_index]), vim.log.levels.WARN)
	end
end

return M
