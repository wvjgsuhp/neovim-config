local constants = require("constants")

return {
  "SmiteshP/nvim-navic",
  config = function()
    require("nvim-navic").setup({
      icons = constants.icons,
      highlight = true,
      separator = " ",
    })
  end,
}
