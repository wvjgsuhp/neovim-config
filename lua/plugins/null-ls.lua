return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local builtins = require("null-ls").builtins
    local on_attach = require("plugins.lspconfig").on_attach

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    require("null-ls").setup({
      -- Ensure key maps are setup
      border = "single",
      on_attach = on_attach,

      sources = {
        -- Whitespace
        builtins.diagnostics.trail_space.with({
          disabled_filetypes = { "gitcommit" },
        }),

        builtins.diagnostics.eslint,
        builtins.formatting.stylua,
        builtins.formatting.sqlformat,
      },
    })
  end,
}
