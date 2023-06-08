return {
  "rmagatti/auto-session",
  cond = vim.g.is_unix == 1,
  opts = {
    log_level = "error",
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { "~/", "~/projects", "/" },
    auto_session_use_git_branch = true,
    bypass_session_save_file_types = { "", "blank", "alpha", "NvimTree", "noice", "notify" },
  },
  cmd = { "SessionRestore", "SessionSave" },
}
