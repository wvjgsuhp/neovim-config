return {
  "rcarriga/nvim-notify",
  config = function()
    local constants = require("constants")
    local utils = require("utils")

    local notify = require("notify")
    local base = require("notify.render.base")
    local namespace = base.namespace()

    local border = {
      ERROR = constants.border.error,
      INFO = constants.border.info,
      TRACE = constants.border.hint,
      WARN = constants.border.warn,
      DEBUG = constants.border.debug,
    }

    local diagnostics = constants.icons.diagnostics
    notify.setup({
      icons = {
        ERROR = diagnostics.error,
        INFO = diagnostics.info,
        TRACE = diagnostics.hint,
        WARN = diagnostics.warn,
      },

      render = function(bufnr, record, _)
        for i = 1, #record.message do
          if not utils.is_empty(record.message[i]) then
            record.message[i] = " " .. record.message[i]
          end
        end

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, record.message)
        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          end_line = #record.message - 1,
          end_col = #record.message[#record.message],
          priority = 50,
        })
      end,

      on_open = function(win, record)
        vim.api.nvim_win_set_config(win, { border = border[record.level] })
      end,

      stages = "static",
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
