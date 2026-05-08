-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
      "typescript",
      "javascript",
      "html",
      "css",
      "go",
      "python",
      "astro",
      "sql",
      "rust",
    },
  },
}
