return {
  "folke/edgy.nvim",
  enabled = false,
  event = "VeryLazy",
  init = function()
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    animate = {
      enabled = false,
    },
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "",
        filter = function(buf)
          return vim.bo[buf].buftype == "terminal"
        end,
        -- size = { height = 0.4 },
        open = ":terminal",
      },
      -- {
      --   ft = "lazyterm",
      --   title = "LazyTerm",
      --   size = { height = 0.4 },
      --   filter = function(buf)
      --     return not vim.b[buf].lazyterm_cmd
      --   end,
      -- },
      "Trouble",
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
  },
}
