return {
  "AndrewRadev/sideways.vim",
  keys = {
    { "<Leader>ah", "<cmd>SidewaysLeft<cr>", desc = "Move an argument to the left" },
    { "<Leader>al", "<cmd>SidewaysRight<cr>", desc = "Move an argument to the right" },
    { "<leader>ai", "<Plug>SidewaysArgumentInsertBefore", desc = "Insert an argument to the left" },
    { "<leader>aa", "<Plug>SidewaysArgumentAppendAfter", desc = "Append an argument to the right" },
    { "<leader>aI", "<Plug>SidewaysArgumentInsertFirst", desc = "Insert an argument to the leftmost" },
    { "<leader>aA", "<Plug>SidewaysArgumentAppendLast", desc = "Append an argument to the rightmost" },
  },
}
