return {
  "tversteeg/registers.nvim",
  opts = {
    window = {
      border = "single",
      transparency = 0,
    },
  },
  keys = {
    { '<Leader>"', mode = { "n", "v" } },
    { "<C-R>", mode = "i" },
  },
  cmd = "Registers",
}
