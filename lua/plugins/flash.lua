return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "fdghjklsaqwertyuiopzxcvbnm",
    label = {
      current = false,
      after = false, ---@type boolean|number[]
      before = true, ---@type boolean|number[]
      -- position of the label extmark
      -- style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
      reuse = "all", ---@type "lowercase" | "all"
    },
    highlight = { backdrop = false },
    modes = {
      char = {
        highlight = { backdrop = false },
        -- keys = {},
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
      "v",
      mode = { "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- {
    --   "S",
    --   mode = { "n", "o", "x" },
    --   function()
    --     require("flash").treesitter()
    --   end,
    --   desc = "Flash Treesitter",
    -- },
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
