local utils = require("utils")

vim.filetype.add({
  extension = {
    pem = "pem",
    mmor = "json",
  },
})

utils.autocmd("BufWrite", {
  pattern = { "*.tex", "*.bib" },
  command = ":%s/\\s\\+$//g",
})

utils.autocmd("FileType", {
  pattern = { "markdown", "tex" },
  callback = function()
    vim.bo.textwidth = tonumber(vim.o.colorcolumn)
  end,
})
