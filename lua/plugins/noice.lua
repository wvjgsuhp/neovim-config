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

    local cmdline_row = math.floor(vim.o.lines * 0.13)

    require("noice").setup({
      cmdline = {
        format = {
          -- 
          cmdline = { title = "", icon = "" },
          search_down = { title = "" },
          search_up = { title = "" },
          filter = { title = "", icon = "" },
          lua = { title = "" },
          help = { title = "" },
          input = { title = "", icon = " " },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = constants.border.none,
            padding = { 0, 0 },
          },
          position = {
            row = cmdline_row,
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
        cmdline_input = {
          border = {
            style = constants.border.none,
            padding = { 0, 0 },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = cmdline_row + 2,
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
