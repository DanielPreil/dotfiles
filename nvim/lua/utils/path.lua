local M = {}

local root_markers = {
	".git",
	".hg",
	".svn",
	"package.json",
	"pyproject.toml",
	"go.mod",
	"Cargo.toml",
	"Makefile",
}

function M.format_project_path(path)
	if type(path) ~= "string" or path == "" then
		return nil
	end

	local normalized = vim.fs.normalize(path)
	local root = vim.fs.root(normalized, root_markers)
	if root and root ~= "" then
		local rel = vim.fs.relpath(root, normalized)
		if rel and rel ~= "" then
			return ("%s/%s"):format(vim.fs.basename(root), rel)
		end
		return vim.fs.basename(root)
	end

	local cwd = (vim.uv and vim.uv.cwd and vim.uv.cwd()) or vim.fn.getcwd()
	if cwd and cwd ~= "" then
		local rel = vim.fs.relpath(vim.fs.normalize(cwd), normalized)
		if rel and rel ~= "" then
			return ("%s/%s"):format(vim.fs.basename(cwd), rel)
		end
	end

	return vim.fs.basename(normalized)
end

function M.copy_path_to_clipboard(path, title)
	local formatted = M.format_project_path(path)
	if not formatted or formatted == "" then
		return
	end

	vim.fn.setreg('"', formatted, "c")
	if vim.fn.has("clipboard") == 1 then
		vim.fn.setreg("+", formatted, "c")
	end

	vim.notify(formatted, vim.log.levels.INFO, { title = title })
end

return M
