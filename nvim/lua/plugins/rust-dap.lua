---@type LazySpec
return {
  -- Override AstroCommunity rust pack's DAP auto-installation
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      -- Remove codelldb from ensure_installed
      if opts.ensure_installed then
        opts.ensure_installed = vim.tbl_filter(function(tool) return tool ~= "codelldb" end, opts.ensure_installed)
      end
      return opts
    end,
  },
}
