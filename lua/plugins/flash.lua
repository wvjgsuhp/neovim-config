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
      reuse = "lowercase", ---@type "lowercase" | "all"
    },
    highlight = { backdrop = false },
    modes = {
      char = {
        enabled = false,
        -- highlight = { backdrop = false },
        -- keys = {},
      },
    },
    prompt = {
      enabled = true,
      prefix = { { " 󰉁 ", "FlashPromptIcon" } },
      win_config = {
        relative = "editor",
        width = 1, -- when <=1 it's a percentage of the editor width
        height = 1,
        row = 0, -- when negative it's an offset from the bottom
        col = 0, -- when negative it's an offset from the right
        zindex = 1000,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "v",
      mode = { "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
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
