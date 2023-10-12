return {
  "AndrewRadev/sideways.vim",
  keys = {
    { "<Leader>ah", "<cmd>SidewaysLeft<cr>",              desc = "Move an arugment to the left" },
    { "<Leader>al", "<cmd>SidewaysRight<cr>",             desc = "Move an arugment to the right" },
    { "<leader>ai", "<Plug>SidewaysArgumentInsertBefore", desc = "Insert an arugment to the left" },
    { "<leader>aa", "<Plug>SidewaysArgumentAppendAfter",  desc = "Move an arugment to the right" },
    { "<leader>aI", "<Plug>SidewaysArgumentInsertFirst",  desc = "Insert an arugment to the leftmost" },
    { "<leader>aA", "<Plug>SidewaysArgumentAppendLast",   desc = "Move an arugment to the rightmost" },
  },
}
