return {
  "supermaven-inc/supermaven-nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    keymaps = {
      accept_suggestion = "<C-l>",
      clear_suggestion = "<C-h>",
      accept_word = "<C-w>",
    },
    ignore_filetypes = { cpp = true },
    color = {
      suggestion_color = "#999988",
      cterm = 246,
    },
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
  },
}
