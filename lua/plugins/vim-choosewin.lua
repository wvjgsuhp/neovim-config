return {
  "t9md/vim-choosewin",
  config = function()
    vim.g.choosewin_label = "ADFGHJKLUIOPQWERT"
    vim.g.choosewin_label_padding = 5
    vim.g.choosewin_overlay_enable = 1
  end,
  keys = {
    { "-", "<Plug>(choosewin)" },
    { "<Leader>-", "<cmd>ChooseWinSwapStay<CR>" },
  },
}
