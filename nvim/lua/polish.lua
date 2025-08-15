-- Enable true color support
if vim.fn.empty(vim.env.TMUX) == 1 then
  if vim.fn.has "termguicolors" == 1 then vim.opt.termguicolors = true end
end

-- Any other custom configurations can go here
