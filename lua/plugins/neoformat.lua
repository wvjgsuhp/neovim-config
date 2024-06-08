local utils = require("utils")

return {
  "sbdchd/neoformat",
  -- enabled = false,
  config = function()
    utils.augroup("neoformat_formatting")
    utils.autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", ",f", "<Cmd>Neoformat<CR>", { noremap = true, silent = true })
      end,
    })
  end,
  ft = { "markdown" },
  cmd = { "Neoformat" },
}
