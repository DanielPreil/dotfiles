---@type LazySpec
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<M-d>",
        ["Find Subword Under"] = "<M-d>",
        ["Select All"] = "<M-S-d>",
      }
    end,
  },
}
