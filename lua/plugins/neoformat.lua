local utils = require("utils")

return {
  "sbdchd/neoformat",
  config = function()
    vim.g.neoformat_sql_sqlformat = {
      exe = "sqlformat",
      args = { "--keywords=upper" },
    }

    vim.g.neoformat_python_autopep8 = {
      exe = "autopep8",
      args = { "--max-line-length=80", "--experimental" },
    }

    utils.augroup("formatting")
    local auto_format_extensions = {
      "*.html",
      "*.java",
      "*.js",
      "*.json",
      "*.jsx",
      "*.lua",
      "*.py",
      "*.rs",
      "*.sql",
      "*.ts",
      "*.tsx",
      "*.yaml",
      "*.R",
    }
    utils.autocmd("BufWritePre", {
      pattern = auto_format_extensions,
      command = "Neoformat",
    })
  end,
}
