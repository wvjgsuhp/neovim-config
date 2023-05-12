local utils = require("utils")

return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup({ stages = "static" })
    vim.notify = notify

    utils.noremap(
      "n",
      "<Leader>yfn",
      "<cmd>let @+=expand('%:t')<CR>:lua vim.notify('Yanked filename: <c-r>+', 'info')<CR>"
    )
    utils.noremap(
      "n",
      "<Leader>yrp",
      "<cmd>let @+=expand('%:~:.')<CR>:lua vim.notify('Yanked relative path: <c-r>+', 'info')<CR>"
    )
    utils.noremap(
      "n",
      "<Leader>yap",
      "<cmd>let @+=expand('%:p')<CR>:lua vim.notify('Yanked absolute path: <c-r>+', 'info')<CR>"
    )
  end,
}
