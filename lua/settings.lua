local utils = require("utils")
local constants = require("constants")

vim.o.scrolloff = 8

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

-- diagnostic
local diag_config = vim.diagnostic.config
local function toggle_virtual_lines()
  diag_config({ virtual_lines = not diag_config().virtual_lines })
end

local function diag_prev()
  vim.diagnostic.jump({ count = -1, float = true })
end

local function diag_next()
  vim.diagnostic.jump({ count = 1, float = true })
end

--- @type vim.diagnostic.Opts.Signs
local signs = { text = {}, numhl = {} }
for type, icon in pairs(constants.icons.diagnostics) do
  local severity = vim.diagnostic.severity[string.upper(type)]
  signs.text[severity] = icon
  signs.numhl[severity] = "DiagnosticSign" .. utils.capitalize(type)
end

diag_config({
  underline = true,
  virtual_lines = false,
  -- virtual_text = {
  --   format = function(_)
  --     return ""
  --   end,
  --   source = false,
  --   prefix = "",
  -- },
  signs = signs,
  float = { border = constants.border.error },
  severity_sort = true,
  update_in_insert = false,
})

utils.map("n", "<Leader>K", toggle_virtual_lines)
utils.map("n", "<Leader>dk", vim.diagnostic.open_float)
utils.noremap("n", "<leader>dn", diag_next)
utils.noremap("n", "<leader>dN", diag_prev)
