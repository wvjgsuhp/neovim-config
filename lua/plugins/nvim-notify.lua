return {
  "rcarriga/nvim-notify",
  config = function()
    local constants = require("constants")

    local notify = require("notify")
    local stages = require("notify.stages.static")("top_down")
    local render = require("notify.render.compact")

    notify.setup({
      icons = {
        ERROR = constants.diagnostics.Error,
        INFO = constants.diagnostics.Info,
        TRACE = constants.diagnostics.Hint,
        WARN = constants.diagnostics.Warn,
      },

      render = function(bufnr, notif, highlights)
        highlights.border = "PmenuPadding"
        return render(bufnr, notif, highlights)
      end,

      stages = {
        function(...)
          local opts = stages[1](...)
          if opts then
            opts.border = constants.border.none
          end
          return opts
        end,
        unpack(stages, 2),
      },
    })

    vim.notify = notify
  end,
  keys = {
    {
      "<Leader>yfn",
      "<cmd>let @+=expand('%:t')<CR>:lua vim.notify('Yanked filename: <c-r>+')<CR>",
      desc = "yank filename",
    },
    {
      "<Leader>yrp",
      "<cmd>let @+=expand('%:~:.')<CR>:lua vim.notify('Yanked relative path: <c-r>+')<CR>",
      desc = "yank relative path",
    },
    {
      "<Leader>yap",
      "<cmd>let @+=expand('%:p')<CR>:lua vim.notify('Yanked absolute path: <c-r>+')<CR>",
      desc = "yank absolute path",
    },
  },
}
