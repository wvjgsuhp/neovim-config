local constants = require("constants")

return {
  "SmiteshP/nvim-navic",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    icons = constants.icons,
    lsp = {
      auto_attach = true,
    },
    highlight = true,
    separator = constants.win_bar_separator,
  },
}
