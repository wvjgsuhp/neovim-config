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
