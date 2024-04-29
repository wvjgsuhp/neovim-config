return {
  "codota/tabnine-nvim",
  -- enabled = false,
  build = "./dl_binaries.sh",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_keymap = "<C-l>",
      dismiss_keymap = "<C-n>",
      debounce_ms = 800,
      suggestion_color = { gui = "#999988", cterm = 246 },
      exclude_filetypes = { "TelescopePrompt" },
      log_file_path = nil, -- absolute path to Tabnine log file
    })
  end,
}
