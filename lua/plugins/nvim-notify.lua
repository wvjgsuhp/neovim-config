local utils = require("utils")

return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    local stages = require("notify.stages.static")("top_down")

    notify.setup({
      render = "compact",
      stages = {
        function(...)
          local opts = stages[1](...)
          if opts then
            opts.border = "single"
          end
          return opts
        end,
        unpack(stages, 2),
      },
    })
    vim.notify = notify

    utils.noremap(
      "n",
      "<Leader>yfn",
      "<cmd>let @+=expand('%:t')<CR>:lua vim.notify('Yanked filename: <c-r>+')<CR>"
    )
    utils.noremap(
      "n",
      "<Leader>yrp",
      "<cmd>let @+=expand('%:~:.')<CR>:lua vim.notify('Yanked relative path: <c-r>+')<CR>"
    )
    utils.noremap(
      "n",
      "<Leader>yap",
      "<cmd>let @+=expand('%:p')<CR>:lua vim.notify('Yanked absolute path: <c-r>+')<CR>"
    )
  end,
}
