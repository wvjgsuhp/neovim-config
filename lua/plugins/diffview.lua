return {
  "sindrets/diffview.nvim",
  config = function()
    local utils = require("utils")
    -- TODO: properly convert to lua
    -- vim.cmd([[
    --   augroup diffview_cursorline
    --     autocmd!
    --     autocmd WinEnter,BufEnter diffview://* setlocal cursorline
    --     autocmd WinEnter,BufEnter diffview:///panels/* setlocal winhighlight=CursorLine:WildMenu
    --   augroup END
    -- ]])

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
      },
    })

    -- esc to close fugitive split
    utils.autocmd({ "WinEnter", "BufEnter" }, {
      pattern = "fugitive:///*",
      callback = function()
        utils.map_buf("n", "<Esc>", "<cmd>q<CR>")
      end,
    })
  end,
  keys = {
    { "<Leader>gdo", "<cmd>DiffviewOpen<cr>" },
    { "<Leader>gds", "<cmd>Gvdiffsplit!<cr>" },
  },
}
