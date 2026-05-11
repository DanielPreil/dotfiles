---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          "css",
          "scss",
        },
      },
      disabled = {},
      timeout_ms = 1000,
    },
    servers = {
      "lua_ls",
    },
    ---@diagnostic disable: missing-fields
    config = {
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = { unknownAtRules = "ignore" },
          },
          scss = {
            validate = true,
            lint = { unknownAtRules = "ignore" },
          },
          less = {
            validate = true,
            lint = { unknownAtRules = "ignore" },
          },
        },
      },
    },
    handlers = {},
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    mappings = {
      n = {
        gd = {
          function()
            local clients = vim.lsp.get_active_clients { bufnr = 0 }
            if #clients == 0 then
              vim.notify("No LSP client attached", vim.log.levels.WARN)
              return
            end
            local client = clients[1]
            local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
            vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
              if err then
                vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
                return
              end
              if not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.INFO)
                return
              end
              local location = vim.tbl_islist(result) and result[1] or result
              vim.lsp.util.jump_to_location(location, client.offset_encoding)
            end)
          end,
          desc = "Go to definition (skip picker)",
          cond = "textDocument/definition",
        },
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
      },
    },
    on_attach = function(client, bufnr)
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 80,
        max_height = 20,
      })
    end,
  },
}
