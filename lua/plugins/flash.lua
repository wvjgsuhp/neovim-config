return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    highlight = {
      label = {
        current = false,
        after = false, ---@type boolean|number[]
        before = true, ---@type boolean|number[]
        -- position of the label extmark
        style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        reuse = "lowercase", ---@type "lowercase" | "all"
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
  },
}
