return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.move").setup {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Use the Shift + Movement keys
        -- Move visual selection in Visual mode.
        left = "<c-h>",
        right = "<c-l>",
        down = "<c-j>",
        up = "<c-k>",
        -- Move current line in Normal mode
        line_left = "<c-h>",
        line_right = "<c-l>",
        line_down = "<c-j>",
        line_up = "<c-k>",
      },
      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    }
  end,
}
