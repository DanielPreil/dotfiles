return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    notify.setup {
      max_width = 50,
      stages = "fade_in_slide_out",
      merge_duplicates = true,
      timeout = 3000,
      min_width = 20,
      background_colour = "#000000",
      fps = 30,
      render = "wrapped-compact",
      top_down = true,
    }
    vim.notify = notify
  end,
}
