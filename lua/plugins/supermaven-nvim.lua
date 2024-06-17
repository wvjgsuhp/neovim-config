return {
  "supermaven-inc/supermaven-nvim",
  build = ":SupermavenUseFree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local constants = require("constants")
    local utils = require("utils")

    local ignore_filetypes = { cpp = true, [""] = true }
    for _, ft in ipairs(constants.non_files) do
      ignore_filetypes[ft] = true
    end

    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-l>",
        clear_suggestion = "<C-h>",
        accept_word = "<C-w>",
      },
      ignore_filetypes = ignore_filetypes,
      color = {
        suggestion_color = "#999988",
        cterm = 246,
      },
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
    })

    utils.emit_event("User", { pattern = "AICompletionStarted" })
  end,
}
