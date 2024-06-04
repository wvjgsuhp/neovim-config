local constants = require("constants")

return {
  "SmiteshP/nvim-navic",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    icons = constants.icons.kinds,
    lsp = {
      auto_attach = true,
    },
    highlight = true,
    separator = constants.win_bar_separator,
  },
}
