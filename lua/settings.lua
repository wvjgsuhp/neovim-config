local utils = require("utils")
local constants = require("constants")

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

utils.autocmd("CursorMoved", {
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(vim.cmd.nohlsearch)
    end
  end,
})

local signs = constants.icons.diagnostics
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. utils.capitalize(type)
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
