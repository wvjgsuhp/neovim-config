return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        rust = { "rustfmt" },
        lua = { "stylua" },
        python = { "isort", "autopep8" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },

        markdown = { "mdformat" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
