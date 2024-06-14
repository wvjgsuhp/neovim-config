if not vim.g.vscode then
  require("settings")
  require("lazy-bootstrap")

  require("lines")
  require("interface")
else
  require("lazy-bootstrap-vscode")
  vim.o.spell = false
end

pcall(require, "local")
