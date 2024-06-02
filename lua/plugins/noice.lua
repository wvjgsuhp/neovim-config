return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local constants = require("constants")
    local utils = require("utils")

    require("noice").setup({
      cmdline = {
        format = {
          cmdline = { title = "", pattern = "^:", icon = "❯", lang = "vim" },
          search_down = { title = "", kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { title = "", kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { title = "", pattern = "^:%s*!", icon = "", lang = "bash" },
          input = { title = "" },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = constants.border.none,
            padding = { 0, 0 },
          },
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 89,
            height = "auto",
          },
          win_options = {
            winblend = 0,
          },
        },
        notify = {
          win_options = {
            winblend = 0,
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 7,
            col = "50%",
          },
          size = {
            width = 89,
            height = 13,
          },
          win_options = {
            winhighlight = { Normal = "Pmenu" },
          },
        },
        hover = {
          border = {
            style = constants.border.hint,
            padding = { 0, 0 },
          },
          position = { row = 2, col = 1 },
          size = {
            max_height = 23,
          },
        },
        mini = {
          win_options = {
            winblend = 8,
          },
        },
        confirm = {
          border = {
            style = "none",
          },
        },
        split = {
          enter = true,
          size = "55%",
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })

    utils.noremap("n", "<Leader>md", "<Cmd>Noice dismiss<CR>")

    local noice_number = utils.augroup("noice_number")
    utils.autocmd({ "FileType", "BufEnter" }, {
      group = noice_number,
      pattern = "noice",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
    })
  end,
}
