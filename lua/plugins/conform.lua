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
        typescriptreact = { { "prettierd", "prettier" } },
        yaml = { "prettier" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 70000,
        lsp_fallback = true,
      },
    })
  end,
}
