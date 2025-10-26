return {
  "rmagatti/auto-session",
  cond = vim.g.is_unix == 1,
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({
      log_level = "error",
      auto_save_enabled = true,
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/projects", "/" },
      auto_session_use_git_branch = true,
      bypass_session_save_file_types = { "", "blank", "alpha", "NvimTree", "noice", "notify" },
    })
  end,
  keys = {
    { "<Leader>rr", ":AutoSession save<CR><Cmd>lua os.exit(1)<CR>" },
  },
}
