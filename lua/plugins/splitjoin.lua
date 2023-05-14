local utils = require("utils")

return {
  "AndrewRadev/splitjoin.vim",
  config = function()
    vim.g.splitjoin_join_mapping = ""
    vim.g.splitjoin_split_mapping = ""
    utils.map("n", "sk", "<cmd>silent! SplitjoinJoin<CR>")
    utils.map("n", "sj", "<cmd>silent! SplitjoinSplit<CR>")
  end,
}
