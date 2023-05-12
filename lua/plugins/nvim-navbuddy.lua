return {
  "SmiteshP/nvim-navbuddy",
  config = function()
    local utils = require("utils")
    utils.noremap("n", "<Leader>fn", "<cmd>Navbuddy<cr>")
  end,
}
