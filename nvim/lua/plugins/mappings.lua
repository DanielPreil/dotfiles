return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["+"] = {
            function()
              local ok, incsel = pcall(require, "nvim-treesitter.incremental_selection")
              if not ok then return end
              -- Always try to init/expand
              if not pcall(incsel.node_incremental) then pcall(incsel.init_selection) end
            end,
            desc = "Expand selection",
          },
          ["-"] = {
            function()
              local ok, incsel = pcall(require, "nvim-treesitter.incremental_selection")
              if not ok then return end
              -- Try shrinking; if it fails, start selection first
              if not pcall(incsel.node_decremental) then pcall(incsel.init_selection) end
            end,
            desc = "Shrink selection",
          },
        },
        x = {
          ["+"] = {
            function()
              local ok, incsel = pcall(require, "nvim-treesitter.incremental_selection")
              if not ok then return end
              pcall(incsel.node_incremental)
            end,
            desc = "Expand selection",
          },
          ["-"] = {
            function()
              local ok, incsel = pcall(require, "nvim-treesitter.incremental_selection")
              if not ok then return end
              pcall(incsel.node_decremental)
            end,
            desc = "Shrink selection",
          },
        },
      },
    },
  },
}
