local utils = require("utils")

return {
  "sbdchd/neoformat",
  -- enabled = false,
  config = function()
    -- vim.g.neoformat_sql_sqlformat = {
    --   exe = "sqlformat",
    --   args = { "--keywords=upper" },
    -- }
    --
    -- vim.g.neoformat_python_autopep8 = {
    --   exe = "autopep8",
    --   args = { "--max-line-length=80", "--experimental" },
    -- }

    utils.augroup("neoformat_formatting")
    -- local auto_format_extensions = {
    --   "*.html",
    --   "*.java",
    --   "*.js",
    --   "*.json",
    --   "*.jsx",
    --   "*.lua",
    --   "*.py",
    --   "*.rs",
    --   "*.sql",
    --   "*.ts",
    --   "*.tsx",
    --   "*.yaml",
    --   "*.R",
    -- }
    -- utils.autocmd("BufWritePre", {
    --   pattern = auto_format_extensions,
    --   command = "Neoformat",
    -- })
    mapping = ",f"
    utils.autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", mapping, "<Cmd>Neoformat<CR>", { noremap = true, silent = true })
      end,
    })
  end,
}
