return {
  "tversteeg/registers.nvim",
  config = function()
    require("registers").setup({
      window = {
        border = "rounded",
        transparency = 0,
      },
    })
  end,
  keys = {
    { '"', mode = { "n", "v" } },
    { "<C-R>", mode = "i" },
  },
  cmd = "Registers",
}
