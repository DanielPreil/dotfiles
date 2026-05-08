return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup {
      lsp = {
        -- AstroLSP kezeli ezeket, noice ne nyúljon hozzájuk
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "written" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = false, -- AstroLSP kezeli a doc bordereket
      },
    }
  end,
  keys = {
    { "<leader>snl", function() require("noice").cmd "last" end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd "history" end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd "all" end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd "dismiss" end, desc = "Dismiss Notifications" },
  },
}
