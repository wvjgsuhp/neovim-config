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
        toml = { "taplo" },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        yaml = { "prettier" },
        tex = { "latexindent" },
        bib = { "bibtex-tidy" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 70000,
        lsp_fallback = true,
      },
    })
  end,
}
