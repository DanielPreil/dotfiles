return {
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "jsx", "tsx", "js", "ts" },
    -- you can omit `dependencies` if you already have nvim-treesitter installed elsewhere
    config = function() require("nvim-ts-autotag").setup() end,
  },
}
