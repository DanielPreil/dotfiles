---@type LazySpec
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<M-d>",
        ["Find Subword Under"] = "<M-d>",
        ["Select All"] = "<M-S-d>",
      }
      vim.g.VM_default_mappings = 0
    end,
  },
}
