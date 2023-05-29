return {
  "tversteeg/registers.nvim",
  config = function()
    require("registers").setup({
      window = {
        border = "single",
        transparency = 0,
      },
    })
  end,
  keys = {
    { '<Leader>"', mode = { "n", "v" } },
    { "<C-R>", mode = "i" },
  },
  cmd = "Registers",
}
