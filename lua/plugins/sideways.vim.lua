local utils = require("utils")

return {
  "AndrewRadev/sideways.vim",
  config = function()
    utils.noremap("n", "<Leader>ah", "<cmd>SidewaysLeft<cr>")
    utils.noremap("n", "<Leader>al", "<cmd>SidewaysRight<cr>")
    utils.noremap("n", "<leader>ai", "<Plug>SidewaysArgumentInsertBefore")
    utils.noremap("n", "<leader>aa", "<Plug>SidewaysArgumentAppendAfter")
    utils.noremap("n", "<leader>aI", "<Plug>SidewaysArgumentInsertFirst")
    utils.noremap("n", "<leader>aA", "<Plug>SidewaysArgumentAppendLast")
  end,
}
