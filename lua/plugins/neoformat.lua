local utils = require('utils')

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

    vim.g.neoformat_lua_stylua = {
      exe = "stylua",
      args = {
        "--indent-type='Spaces'",
        "--indent-width=2",
        "--column-width=112",
      },
      replace = 1,
    }

    utils.augroup('formatting')
    local auto_format_extensions = {
        '*.html',
        '*.java',
        '*.js',
        '*.json',
        '*.jsx',
        '*.lua',
        '*.py',
        '*.rs',
        '*.sql',
        '*.ts',
        '*.tsx',
        '*.yaml',
        '*.R',
    }
    utils.autocmd('BufWritePre', {
      pattern=auto_format_extensions,
      callback='Neoformat'
    })
    -- vim.cmd([[
    --   augroup formatting
    --     autocmd!
    --     autocmd BufWritePre *.html Neoformat
    --     autocmd BufWritePre *.java Neoformat
    --     autocmd BufWritePre *.js Neoformat
    --     autocmd BufWritePre *.json Neoformat
    --     autocmd BufWritePre *.jsx Neoformat
    --     autocmd BufWritePre *.lua Neoformat
    --     autocmd BufWritePre *.py Neoformat
    --     autocmd BufWritePre *.rs Neoformat
    --     autocmd BufWritePre *.sql Neoformat
    --     autocmd BufWritePre *.ts Neoformat
    --     autocmd BufWritePre *.tsx Neoformat
    --     autocmd BufWritePre *.yaml Neoformat
    --     autocmd BufWritePre *.R Neoformat
    --   augroup END
    -- ]])
  end,
}
