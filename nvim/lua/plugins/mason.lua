---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "tailwindcss-language-server",
        "emmet-ls",
        "json-lsp",
        "vue-language-server",
        "html-lsp",
        "css-lsp",
        "prisma-language-server",
        "lua-language-server",
        "stylua",
      },
      run_on_start = false,
    },
  },
}
