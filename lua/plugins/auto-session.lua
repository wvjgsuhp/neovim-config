return {
  "rmagatti/auto-session",
  config = function()
    local utils = require("utils")

    require("auto-session").setup({
      log_level = "error",
      auto_save_enabled = true,
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/projects", "/" },
      auto_session_use_git_branch = true,
      bypass_session_save_file_types = { "", "blank", "alpha", "NvimTree", "noice", "notify" },
    })

    utils.noremap("n", "<Leader>sr", "<Cmd>SessionRestore<CR>")
  end,
}
