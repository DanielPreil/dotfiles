---@type LazySpec
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = false,
        show_end = false,
        include = {
          node_type = {
            lua = {
              "function_declaration",
              "function_definition",
              "function_call",
              "table_constructor",
              "if_statement",
              "for_statement",
              "while_statement",
              "do_statement",
            },
            typescript = {
              "statement_block",
              "object",
              "array",
              "function",
              "arrow_function",
              "method_definition",
              "if_statement",
              "for_statement",
            },
            vue = {
              "element",
              "script_element",
              "style_element",
              "object",
              "array",
              "function",
              "arrow_function",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "alpha",
          "neo-tree",
          "NvimTree",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2f2f46" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#8be9fd" })
    end,
  },
}
