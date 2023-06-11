return {
  "SmiteshP/nvim-navbuddy",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "SmiteshP/nvim-navic",
  },
  config = function()
    local constants = require("constants")
    local utils = require("utils")

    require("nvim-navbuddy").setup({
      window = {
        sections = {
          left = {
            border = { style = { " ", " ", " ", " ", " ", " ", " ", " " } },
          },
          mid = {
            border = { style = { " ", " ", " ", "│", " ", " ", " ", "│" } },
          },
        },
      },
      node_markers = {
        enabled = true,
        icons = {
          leaf = "  ",
          leaf_selected = "  ",
          branch = " ",
        },
      },
      icons = constants.icons,
      lsp = {
        auto_attach = true, -- If set to true, you don't need to manually use attach function
      },
    })

    -- utils.augroup("highlight_navbuddy")
    -- utils.autocmd("FileType", {
    --   group = "highlight_navbuddy",
    --   pattern = "Navbuddy",
    --   command = "highlight! link EndOfBuffer PmenuEnd",
    -- })
    -- utils.autocmd({ "FileType", "BufWinEnter" }, {
    --   group = "highlight_navbuddy",
    --   pattern = "Navbuddy",
    --   command = "set winhighlight+=EndOfBuffer:PmenuEnd",
    -- })
    -- utils.autocmd({ "FileType", "BufWinEnter" }, {
    --   group = "highlight_navbuddy",
    --   pattern = "Navbuddy",
    --   command = "echo 'ssssdf'",
    -- })
    -- utils.autocmd("BufLeave", {
    --   group = "highlight_navbuddy",
    --   pattern = "Navbuddy",
    --   command = "highlight! EndOfBuffer ctermfg=255 ctermbg=255 guifg=#F8F8FF guibg=#F8F8FF",
    -- })
  end,
  keys = {
    { "<Leader>fn", "<cmd>Navbuddy<cr>" },
  },
}
