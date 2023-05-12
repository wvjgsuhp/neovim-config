local utils = require("utils")

return {
  "AndrewRadev/splitjoin.vim",
  config = function()
    vim.g.splitjoin_join_mapping = ""
    vim.g.splitjoin_split_mapping = ""
    utils.noremap("n", "sj", "<cmd>SplitjoinJoin<CR>")
    utils.noremap("n", "ss", "<cmd>SplitjoinSplit<CR>")
  end,
}
