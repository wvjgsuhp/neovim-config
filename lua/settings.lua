local utils = require("utils")

vim.filetype.add({
  extension = {
    pem = "pem",
  },
})

utils.autocmd("BufWrite", {
  pattern = { "*.tex" },
  command = ":%s/\\s\\+$//g",
})
