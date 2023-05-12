return {
  "t9md/vim-choosewin",
  config = function()
    vim.g.choosewin_label = "ADFGHJKLUIOPQWERT"
    vim.g.choosewin_label_padding = 5

    local utils = require("utils")
    utils.noremap("n", "-", "<Plug>(choosewin)")
    utils.noremap("n", "<Leader>-", "<cmd>ChooseWinSwapStay<CR>")
  end,
}
