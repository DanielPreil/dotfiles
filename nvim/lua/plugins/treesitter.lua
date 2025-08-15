---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  enable = true,
  ensure_installed = {
    "lua",
    "vim",
    "astro",
    "dart",
    "rust",
    "typescript",
    "javascript",
    "go",
    "glsl",
    "html",
    "css",
    "json",
    "markdown",
    "zig",
    "svelte",
    "sql",
  },
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = false,
        node_incremental = false,
        scope_incremental = false,
        node_decremental = false,
      },
    },
  },
}
