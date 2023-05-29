local utils = require("utils")

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- plugin: gitsigns.nvim
    -- see: https://github.com/lewis6991/gitsigns.nvim
    -- rafi settings

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
      keymaps = {
        noremap = true,

        ["n ]g"] = {
          expr = true,
          "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
        },
        ["n [g"] = {
          expr = true,
          "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
        },

        -- Text objects
        ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
        ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
      },
    })

    utils.noremap("n", "gh", "<cmd>Gitsigns next_hunk<CR>zz")
  end,
}
