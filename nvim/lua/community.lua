-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.biome" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.comment.mini-comment" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.recipes.disable-tabline" },
}
