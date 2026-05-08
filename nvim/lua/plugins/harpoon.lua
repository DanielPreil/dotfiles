return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    harpoon:extend {
      UI_CREATE = function(cx)
        vim.keymap.set("n", "l", function() harpoon.ui:select_menu_item {} end, { buffer = cx.bufnr })
      end,
    }
  end,
  keys = {
    { "<leader>A", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
    {
      "<leader>a",
      function()
        local h = require "harpoon"
        h.ui:toggle_quick_menu(h:list())
      end,
      desc = "Harpoon quick menu",
    },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
  },
}
