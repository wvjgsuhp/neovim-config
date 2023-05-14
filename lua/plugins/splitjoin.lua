return {
  "AndrewRadev/splitjoin.vim",
  config = function()
    vim.g.splitjoin_join_mapping = ""
    vim.g.splitjoin_split_mapping = ""
  end,
  keys = {
    { "sj", "<cmd>SplitjoinJoin<CR>" },
    { "ss", "<cmd>SplitjoinSplit<CR>" },
  },
}
