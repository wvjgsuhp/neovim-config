return {
  "VonHeikemen/fine-cmdline.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("fine-cmdline").setup({
      cmdline = {
        enable_keymaps = true,
        smart_history = true,
        prompt = " ",
      },
      popup = {
        position = {
          row = "10%",
          col = "50%",
        },
        size = {
          width = "60%",
        },
        border = {
          style = "rounded",
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      },
    })

    local utils = require("utils")
    utils.noremap("n", ":", "<cmd>FineCmdline<CR>")
    utils.noremap("x", ":", "<cmd>FineCmdline '<,'><CR>")
  end,
}
