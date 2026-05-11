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
    filetypes = {},
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        nrformats = { "bin", "hex", "alpha" },
      },

      g = {
        -- global vim.g values if needed
      },
    },

    -- Mappings through AstroCore (this is the correct place for plugin spec mappings)
    mappings = {
      v = {
        ["<leader>dc"] = {
          function()
            -- escape visual mode először, hogy '<,'> markok frissüljenek
            local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
            vim.api.nvim_feedkeys(esc, "x", false)
            local start = vim.fn.line "'<"
            local finish = vim.fn.line "'>"
            vim.cmd(start .. "," .. finish .. "s/ *--.*$//e")
          end,
          desc = "Delete inline comments",
        },
      },
      n = {
        ["<leader>dc"] = {
          function() vim.cmd [[s/ *--.*$//e]] end,
          desc = "Delete inline comment",
        },
        -- navigate buffer tabs using existing motions
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<leader>tt"] = {
          function()
            local word = vim.fn.expand "<cword>"
            if word == "true" then
              vim.cmd "normal! ciwfalse"
            elseif word == "false" then
              vim.cmd "normal! ciwtrue"
            end
          end,
          desc = "Toggle true/false",
        }, -- TAB / SHIFT-TAB in normal mode -> next / previous buffer
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
