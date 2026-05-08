return {
  -- "morhetz/gruvbox",
  -- name = "gruvbox",

  -- "oskarnurm/koda.nvim",
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  -- config = function()
  --   -- require("koda").setup({ transparent = true })
  --   vim.cmd "colorscheme koda"
  -- end,

  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function() vim.cmd "colorscheme rose-pine-main" end,
}
