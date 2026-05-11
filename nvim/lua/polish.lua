vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function() vim.w._saved_view = vim.fn.winsaveview() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format {
      async = false,
      timeout_ms = 1000,
    }
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    if vim.w._saved_view then
      vim.fn.winrestview(vim.w._saved_view)
      vim.w._saved_view = nil
    end
  end,
})

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

for alias, cmd in pairs(cmds) do
  vim.api.nvim_create_user_command(alias, cmd, {})
end
