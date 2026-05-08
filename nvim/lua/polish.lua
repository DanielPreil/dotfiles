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

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("WQa", "wqa", {})
vim.api.nvim_create_user_command("WQA", "wqa", {})
