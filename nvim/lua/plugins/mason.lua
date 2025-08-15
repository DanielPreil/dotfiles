---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript/JavaScript
        "vtsls", -- TypeScript Language server
        "eslint-lsp", -- JavaScript/TypeScript linting
        "prettierd", -- Code formatting for web languages

        -- Web Frontend
        "tailwindcss-language-server", -- Tailwind CSS support
        "css-lsp", -- CSS language server
        "html-lsp", -- HTML language server
        "emmet-ls", -- HTML/CSS snippets and expansion
        "json-lsp", -- JSON language server

        -- Backend/Database
        "prisma-language-server", -- Prisma ORM support

        -- Docker
        "dockerfile-language-server", -- Docker file support
        "docker-compose-language-service", -- Docker compose support

        -- Python
        "basedpyright", -- Python language server
        "black", -- Python formatter
        "debugpy", -- Python debugging

        -- Utils
        "tree-sitter-cli", -- TreeSitter parser generator
        "js-debug-adapter", -- JavaScript debugging

        -- Neovim config
        "lua-language-server", -- Lua language server
        "stylua", -- Lua formatter
      },
      automatic_installation = true,
    },
  },
}
