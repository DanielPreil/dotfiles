-- ~/.config/nvim/lua/user/your_astrocore_file.lua
-- NOTE: remove any top guard like `if true then return {} end` to activate this file @type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    filetypes = {
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
      },
      g = {
        -- global vim.g values if needed
      },
    },

    -- Mappings through AstroCore (this is the correct place for plugin spec mappings)
    mappings = {
      n = {
        -- navigate buffer tabs using existing motions
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- TAB / SHIFT-TAB in normal mode -> next / previous buffer
        -- Note: uses vim.v.count1 so counts like 2<Tab> will move 2 buffers
        -- ["<Tab>"] = {
        --   function() require("astrocore.buffer").nav(vim.v.count1) end,
        --   desc = "Next buffer (Tab)",
        -- },
        -- ["<S-Tab>"] = {
        --   function() require("astrocore.buffer").nav(-vim.v.count1) end,
        --   desc = "Previous buffer (Shift-Tab)",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- example of disabling a mapping:
        -- ["<C-S>"] = false,

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
      },
    },
  },
}
