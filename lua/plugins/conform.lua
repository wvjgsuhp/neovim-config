return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        bib = { "bibtex-tidy" },
        java = { "google-java-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        python = { "isort", "black" },
        r = { "air" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        tex = { "latexindent" },
        toml = { "taplo" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettier" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "112" },
        },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    })
  end,
}
