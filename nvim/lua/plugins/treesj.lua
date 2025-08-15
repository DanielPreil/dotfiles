return {
  "Wansmer/treesj",
  dekeys = {
    { "<leader>m", desc = "Split or Join code block with autodetect" },
    { "<leader>j", desc = "join code block" },
    { "<leader>s", desc = "Split code block" },
  },
  pendencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function() require("treesj").setup {} end,
}
