---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.win = opts.win or {}

      -- Ne próbálja mindenáron elkerülni a kurzort,
      -- így egységesebb méretű marad a popup.
      opts.win.no_overlap = false

      opts.layout = opts.layout or {}
      opts.layout.height = {
        min = 4,
        max = 25,
      }

      return opts
    end,
  },
}
