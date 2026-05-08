---@type LazySpec
return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "VeryLazy",
    opts = {
      mode = "time_driven",
      enable_deceleration = false,
      acceleration_limit = 90,
      acceleration_table = { 1, 2, 2, 3, 4 },
    },
    keys = {
      { "<M-j>", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "Move down accelerated" },
      { "<M-k>", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "Move up accelerated" },
    },
  },
}
