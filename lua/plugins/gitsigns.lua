return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local utils = require("utils")

    require("gitsigns").setup({
      signs = {
        add = { text = "▍" },
        change = { text = "▍" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      preview_config = {
        border = "single",
      },
      trouble = false,
    })

    utils.noremap("n", "gh", "<cmd>Gitsigns next_hunk<CR>zz")
    utils.noremap("n", "gH", "<cmd>Gitsigns prev_hunk<CR>zz")
    utils.noremap("n", "gp", "<cmd>Gitsigns preview_hunk_inline<CR>zz")
  end,
}
