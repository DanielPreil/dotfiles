local cmds = {
	W = "w",
	Wa = "wa",
	WA = "wa",
	Q = "q",
	Qa = "qa",
	QA = "qa",
	Wq = "wq",
	WQ = "wq",
	Wqa = "wqa",
	WQa = "wqa",
	WQA = "wqa",
}

local theme = require("utils.theme")

for alias, cmd in pairs(cmds) do
	vim.api.nvim_create_user_command(alias, cmd, { force = true })
end

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up centered" })

local bool_toggle = {
	["true"] = "false",
	["false"] = "true",
	["True"] = "False",
	["False"] = "True",
	["TRUE"] = "FALSE",
	["FALSE"] = "TRUE",
}

local function is_word_char(ch)
	return ch ~= "" and ch:match("[%w_]") ~= nil
end

local function toggle_boolean_under_cursor()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row = pos[1]
	local col = pos[2]
	local line = vim.api.nvim_get_current_line()
	local idx = col + 1

	if idx < 1 or idx > #line then
		return
	end

	if not is_word_char(line:sub(idx, idx)) and idx > 1 and is_word_char(line:sub(idx - 1, idx - 1)) then
		idx = idx - 1
	end

	if not is_word_char(line:sub(idx, idx)) then
		vim.notify("No boolean under cursor", vim.log.levels.INFO)
		return
	end

	local start_idx = idx
	local end_idx = idx

	while start_idx > 1 and is_word_char(line:sub(start_idx - 1, start_idx - 1)) do
		start_idx = start_idx - 1
	end

	while end_idx < #line and is_word_char(line:sub(end_idx + 1, end_idx + 1)) do
		end_idx = end_idx + 1
	end

	local current = line:sub(start_idx, end_idx)
	local replacement = bool_toggle[current]

	if not replacement then
		vim.notify("No boolean under cursor", vim.log.levels.INFO)
		return
	end

	vim.api.nvim_buf_set_text(0, row - 1, start_idx - 1, row - 1, end_idx, { replacement })
end

vim.keymap.set("n", "<leader>uB", toggle_boolean_under_cursor, { desc = "Toggle boolean under cursor" })

local explorer_state = {
	last_code_win = nil,
}

local function get_snacks_explorer_win()
	local ok, snacks = pcall(require, "snacks")
	if not ok or not snacks or not snacks.picker or not snacks.picker.get then
		return nil
	end

	local current_tab = vim.api.nvim_get_current_tabpage()
	local pickers = snacks.picker.get({ source = "explorer", tab = true }) or {}
	for _, picker in ipairs(pickers) do
		local win = picker.list and picker.list.win and picker.list.win.win or nil
		if
			type(win) == "number"
			and vim.api.nvim_win_is_valid(win)
			and vim.api.nvim_win_get_tabpage(win) == current_tab
		then
			return win
		end
	end

	return nil
end

local function is_explorer_win(win)
	local explorer_win = get_snacks_explorer_win()
	if not explorer_win then
		return nil
	end
	return win == explorer_win
end

local function find_first_code_win()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if not is_explorer_win(win) then
			return win
		end
	end
end

local function toggle_explorer_focus()
	local current_win = vim.api.nvim_get_current_win()

	if is_explorer_win(current_win) then
		local target = explorer_state.last_code_win
		if not (target and vim.api.nvim_win_is_valid(target) and not is_explorer_win(target)) then
			target = find_first_code_win()
		end
		if target then
			vim.api.nvim_set_current_win(target)
		end
		return
	end

	explorer_state.last_code_win = current_win

	local explorer_win = get_snacks_explorer_win()
	if explorer_win then
		vim.api.nvim_set_current_win(explorer_win)
		return
	end

	local ok, snacks = pcall(require, "snacks")
	if ok and snacks and snacks.explorer and snacks.explorer.open then
		snacks.explorer.open()
		vim.schedule(function()
			local scheduled_explorer_win = get_snacks_explorer_win()
			if scheduled_explorer_win then
				vim.api.nvim_set_current_win(scheduled_explorer_win)
			end
		end)
		return
	end
end

vim.keymap.set("n", "<leader>o", toggle_explorer_focus, { desc = "Toggle focus: Explorer <-> Code" })

vim.keymap.set("n", "<leader>uN", function()
	theme.cycle(1)
end, { desc = "Cycle colorscheme (saved)" })

vim.keymap.set("n", "<leader>ya", function()
	vim.cmd("%y+")
	vim.notify("Copied entire file to clipboard")
end, { desc = "Copy entire file" })
