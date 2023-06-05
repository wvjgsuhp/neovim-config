return {
  "sindrets/diffview.nvim",
  config = function()
    vim.cmd([[
      augroup diffview_cursorline
        autocmd!
        autocmd WinEnter,BufEnter diffview://* setlocal cursorline
        autocmd WinEnter,BufEnter diffview:///panels/* setlocal winhighlight=CursorLine:WildMenu
      augroup END
    ]])

    require("diffview").setup({
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      key_bindings = {
        view = {
          ["<esc>"] = "<cmd>DiffviewClose<CR>",
          ["q"] = "<cmd>DiffviewClose<CR>",
        },
        file_panel = {
          ["<esc>"] = "<cmd>DiffviewClose<CR>",
          ["q"] = "<cmd>DiffviewClose<CR>",
        },
        -- file_history_panel = {},
        -- option_panel = {},
      },
    })
  end,
  keys = {
    { "<Leader>gdo", "<cmd>DiffviewOpen<cr>" },
    { "<Leader>gds", "<cmd>Gvdiffsplit!<cr>" },
  },
}
