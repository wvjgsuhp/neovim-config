return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    local hl_color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("StatusLine")), "fg", "gui")
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          left_top = "┌",
          left_bottom = "└",
          right_arrow = "─",
        },
        style = {
          { fg = hl_color },
        },
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
      },
      line_num = {
        enable = false,
      },
    })
  end,
}
